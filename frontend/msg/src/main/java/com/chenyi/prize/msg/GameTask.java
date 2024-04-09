package com.chenyi.prize.msg;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chenyi.prize.commons.config.RedisKeys;
import com.chenyi.prize.commons.db.entity.CardGame;
import com.chenyi.prize.commons.db.entity.CardGameRules;
import com.chenyi.prize.commons.db.entity.CardProductDto;
import com.chenyi.prize.commons.db.service.CardGameProductService;
import com.chenyi.prize.commons.db.service.CardGameRulesService;
import com.chenyi.prize.commons.db.service.CardGameService;
import com.chenyi.prize.commons.db.service.GameLoadService;
import com.chenyi.prize.commons.db.service.impl.CardGameServiceImpl;
import com.chenyi.prize.commons.utils.RedisUtil;
import javafx.util.Pair;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 活动信息预热，每隔1分钟执行一次
 * 查找未来1分钟内（含），要开始的活动
 */
@Component
public class GameTask {
    private final static Logger log = LoggerFactory.getLogger(GameTask.class);
    @Autowired
    private CardGameService gameService;
    @Autowired
    private CardGameProductService gameProductService;
    @Autowired
    private CardGameRulesService gameRulesService;
    @Autowired
    private GameLoadService gameLoadService;
    @Autowired
    private RedisUtil redisUtil;

    @Scheduled(cron = "0 * * * * ?")
    public void execute() {
        log.info("scheduled!"+new Date());

        // 将当前时间加一分钟
        Date now = new Date();
        Date newDate = DateUtils.addMinutes(now, 1);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        LambdaQueryWrapper<CardGame> lqw = new LambdaQueryWrapper();
        lqw.ge(CardGame::getStarttime, dateFormat.format(now)).lt(CardGame::getStarttime, dateFormat.format(newDate));
        List<CardGame> gameList = gameService.list(lqw);

        // 查询规则
        List<CardGameRules> ruleList = gameRulesService.list();
        Map<Integer, List<CardGameRules>> map = new HashMap<>();
        // 放入map方便查询
        for (CardGameRules rule : ruleList) {
            List list = map.get(rule.getGameid());
            if(list == null){
                list = new ArrayList();
            }
            list.add(rule);
            map.put(rule.getGameid(), list);
        }


        for (CardGame game : gameList) {
            if(game.getType() == 1){
                // 缓存活动信息
                redisUtil.set(RedisKeys.INFO + game.getId(), game, -1);
                long duration =game.getEndtime().getTime() - game.getStarttime().getTime();
                // 缓存活动策略信息
                List<CardGameRules> rulesList = map.get(game.getId());
                for (CardGameRules r : rulesList) {
                    redisUtil.hset(RedisKeys.MAXGOAL + game.getId(), r.getUserlevel() + "", r.getGoalTimes(), duration / 1000 + 5);
                    redisUtil.hset(RedisKeys.MAXENTER + game.getId(), r.getUserlevel() + "", r.getEnterTimes(), duration / 1000 + 5);
                }

                // 缓存令牌桶
                List<CardProductDto> productList = gameLoadService.getByGameId(game.getId());
                long sum = 0;
                for (CardProductDto item : productList) {
                    sum += item.getAmount();
                }
                List<Long> tokenList = generateToken(sum, game.getStarttime().getTime(), game.getEndtime().getTime());
                List<Pair<Long, CardProductDto>> pairList = new ArrayList<>();
                int idx = 0;

                for (CardProductDto item : productList) {
                    for (Integer j = 0; j < item.getAmount(); j++) {
                        pairList.add(new Pair(tokenList.get(idx) , item));
                        redisUtil.set(RedisKeys.TOKEN + game.getId() + "_" + tokenList.get(idx), item, duration / 1000);
                        idx ++;
                    }
                }
                tokenList.sort(Comparator.comparing(Long::valueOf));
                String tokensKey = RedisKeys.TOKENS + game.getId();
                redisUtil.rightPushAll(tokensKey, tokenList);
                redisUtil.expire(tokensKey, duration / 1000 + 5);
            }
        }
    }

    public static List<Long> generateToken(long length, long start, long end){
        long duration = end - start;
        List<Long> list = new ArrayList<>();
        for (long i = 0; i < length; i++) {
            //活动持续时间（ms）
            long rnd = start + new Random().nextInt((int)duration);
            //为什么乘1000，再额外加一个随机数呢？ - 防止时间段奖品多时重复
            long token = rnd * 1000 + new Random().nextInt(999);
            list.add(token);
        }
        return list;
    }

    public static void main(String[] args) {
        // 将当前时间加一分钟
        long oneMinuteInMillis = 1 * 60 * 1000; // 一分钟的毫秒数
        Date now = new Date();
        Date newDate = new Date(now.getTime() + oneMinuteInMillis);

        LambdaQueryWrapper<CardGame> lqw = new LambdaQueryWrapper();
        lqw.lt(CardGame::getStarttime, now.getTime()).ge(CardGame::getStarttime, newDate);
        CardGameService gameService = new CardGameServiceImpl();
        List<CardGame> gameList = gameService.list(lqw);
        System.out.println(gameList);
    }
}
