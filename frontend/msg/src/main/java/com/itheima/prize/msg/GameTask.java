package com.itheima.prize.msg;

import com.itheima.prize.commons.config.RedisKeys;
import com.itheima.prize.commons.db.entity.*;
import com.itheima.prize.commons.db.mapper.CardGameMapper;
import com.itheima.prize.commons.db.mapper.CardGameProductMapper;
import com.itheima.prize.commons.db.mapper.CardGameRulesMapper;
import com.itheima.prize.commons.db.mapper.GameLoadMapper;
import com.itheima.prize.commons.utils.RedisUtil;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * 活动信息预热，每隔1分钟执行一次
 * 查找未来1分钟内（含），要开始的活动
 */
@Component
public class GameTask {
    private final static Logger log = LoggerFactory.getLogger(GameTask.class);
    @Autowired
    private CardGameMapper gameMapper;
    @Autowired
    private CardGameProductMapper gameProductMapper;
    @Autowired
    private CardGameRulesMapper gameRulesMapper;
    @Autowired
    private GameLoadMapper gameLoadMapper;
    @Autowired
    private RedisUtil redisUtil;

    @Scheduled(cron = "0 * * * * ?")
    public void execute() {
        //当前时间
        Date now = new Date();
        //查询将来1分钟内要开始的活动
        CardGameExample example = new CardGameExample();
        CardGameExample.Criteria criteria = example.createCriteria();
        //开始时间大于当前时间
        criteria.andStarttimeGreaterThan(now);
        //小于等于（当前时间+1分钟）
        criteria.andStarttimeLessThanOrEqualTo(DateUtils.addMinutes(now,1));
        List<CardGame> list = gameMapper.selectByExample(example);
        if(list.size() == 0){
            //没有查到要开始的活动
            log.info("game list scan : size = 0");
            return;
        }
        log.info("game list scan : size = {}",list.size());
        //有相关活动数据，则将活动数据预热，进redis
        list.forEach(game ->{
            //活动开始时间
            long start = game.getStarttime().getTime();
            //活动结束时间
            long end = game.getEndtime().getTime();
            //计算活动结束时间到现在还有多少秒，作为redis key过期时间
            long expire = (end - now.getTime())/1000;
//            long expire = -1; //永不过期
            //活动持续时间（ms）
            long duration = end - start;

            //活动基本信息
            game.setStatus(1);
            redisUtil.set(RedisKeys.INFO+game.getId(),game,-1);
            log.info("load game info:{},{},{},{}", game.getId(),game.getTitle(),game.getStarttime(),game.getEndtime());

            //活动奖品信息
            List<CardProductDto> products = gameLoadMapper.getByGameId(game.getId());
            Map<Integer,CardProduct> productMap = new HashMap<>(products.size());
            products.forEach(p -> productMap.put(p.getId(),p));
            log.info("load product type:{}",productMap.size());

            //奖品数量等配置信息
            CardGameProductExample productExample = new CardGameProductExample();
            productExample.createCriteria().andGameidEqualTo(game.getId());
            List<CardGameProduct> gameProducts = gameProductMapper.selectByExample(productExample);
            log.info("load bind product:{}",gameProducts.size());

            //令牌桶
            List<Long> tokenList = new ArrayList();
            gameProducts.forEach(cgp ->{
                //生成amount个start到end之间的随机时间戳做令牌
                for (int i = 0; i < cgp.getAmount(); i++) {
                    long rnd = start + new Random().nextInt((int)duration);
                    //为什么乘1000，再额外加一个随机数呢？ - 防止时间段奖品多时重复
                    //记得取令牌判断时间时，除以1000，还原真正的时间戳
                    long token = rnd * 1000 + new Random().nextInt(999);
                    //将令牌放入令牌桶
                    tokenList.add(token);
                    //以令牌做key，对应的商品为value，创建redis缓存
                    log.info("token -> game : {} -> {}",token/1000 ,productMap.get(cgp.getProductid()).getName());
                    //token到实际奖品之间建立映射关系
                    redisUtil.set(RedisKeys.TOKEN + game.getId() +"_"+token,productMap.get(cgp.getProductid()),expire);
                }
            });
            //排序后放入redis队列
            Collections.sort(tokenList);
            log.info("load tokens:{}",tokenList);

            //从右侧压入队列，从左到右，时间戳逐个增大
            redisUtil.rightPushAll(RedisKeys.TOKENS + game.getId(),tokenList);
            redisUtil.expire(RedisKeys.TOKENS + game.getId(),expire);

            //奖品策略配置信息
            CardGameRulesExample rulesExample = new CardGameRulesExample();
            rulesExample.createCriteria().andGameidEqualTo(game.getId());
            List<CardGameRules> rules = gameRulesMapper.selectByExample(rulesExample);
            //遍历策略，存入redis hset
            rules.forEach(r -> {
                redisUtil.hset(RedisKeys.MAXGOAL +game.getId(),r.getUserlevel()+"",r.getGoalTimes());
                redisUtil.hset(RedisKeys.MAXENTER +game.getId(),r.getUserlevel()+"",r.getEnterTimes());
                redisUtil.hset(RedisKeys.RANDOMRATE +game.getId(),r.getUserlevel()+"",r.getRandomRate());
                log.info("load rules:level={},enter={},goal={},rate={}",
                        r.getUserlevel(),r.getEnterTimes(),r.getGoalTimes(),r.getRandomRate());
            });
            redisUtil.expire(RedisKeys.MAXGOAL +game.getId(),expire);
            redisUtil.expire(RedisKeys.MAXENTER +game.getId(),expire);
            redisUtil.expire(RedisKeys.RANDOMRATE +game.getId(),expire);


            //活动状态变更为已预热，禁止管理后台再随便变动
            game.setStatus(1);
            gameMapper.updateByPrimaryKey(game);
        });
    }
}
