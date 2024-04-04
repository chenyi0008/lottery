package com.chenyi.prize.api.action;

import com.alibaba.fastjson.JSON;
import com.chenyi.prize.api.config.LuaScript;
import com.chenyi.prize.commons.annotition.limit.Limit;
import com.chenyi.prize.commons.annotition.limit.LimitType;
import com.chenyi.prize.commons.db.entity.*;
import com.chenyi.prize.commons.config.RabbitKeys;
import com.chenyi.prize.commons.config.RedisKeys;
import com.chenyi.prize.commons.db.service.CardGameRulesService;
import com.chenyi.prize.commons.db.service.CardGameService;
import com.chenyi.prize.commons.db.service.GameLoadService;
import com.chenyi.prize.commons.utils.ApiResult;
import com.chenyi.prize.commons.utils.RedisUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import javafx.util.Pair;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;


@RestController
@RequestMapping("/api/act")
@Api(tags = {"抽奖模块"})
public class ActController {

    @Autowired
    private RedisUtil redisUtil;
    @Autowired
    private RabbitTemplate rabbitTemplate;
    @Autowired
    private LuaScript luaScript;
    @Autowired
    private CardGameRulesService gameRulesService;
    @Autowired
    private GameLoadService gameLoadService;
    @Autowired
    private CardGameService gameService;

    static int defaultMaxEnterTime = 10;
    static int defaultMaxGoalTime = 20;

    @Limit(key = "lottery", limitType = LimitType.CUSTOMER, name = "抽奖", period = 10, count = 5)
    @GetMapping("/go/{gameid}")
    @ApiOperation(value = "抽奖")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",example = "1",required = true)
    })
    public ApiResult<Object> act(@PathVariable int gameid, HttpServletRequest request){
        // 获取活动信息 判断活动是否进行中
        CardGame game = (CardGame) redisUtil.get(RedisKeys.INFO + gameid);
        Date now = new Date();
        if(game == null || game.getStarttime().compareTo(now) > 0){
            return new ApiResult(-1,"比赛还未开始",null);
        }else if (game.getEndtime().compareTo(now) < 0){
            return new ApiResult(-1,"比赛已结束",null);
        }

        // 判断抽奖次数
        CardUser user = (CardUser) request.getSession().getAttribute("user");

        Integer userEnter = (Integer) redisUtil.get(RedisKeys.USERENTER + gameid + "_" + user.getId());
        Integer maxEnterTimes = (Integer) redisUtil.hget(RedisKeys.MAXENTER + gameid, user.getLevel().toString());
        if(maxEnterTimes == null)maxEnterTimes = defaultMaxEnterTime;
        if(userEnter == null){
            redisUtil.set(RedisKeys.USERENTER + gameid + "_" + user.getId(), 1);

            // mq保存参加活动记录
            CardUserGame cardUserGame = new CardUserGame();
            cardUserGame.setGameid(gameid);
            cardUserGame.setUserid(user.getId());
            cardUserGame.setCreatetime(now);
            String jsonString = JSON.toJSONString(cardUserGame);
            rabbitTemplate.convertAndSend(RabbitKeys.QUEUE_PLAY, jsonString);
        }else{
            if(userEnter >= maxEnterTimes)return new ApiResult<>(-1,"您的抽奖次数已用完",null);
        }
        redisUtil.incr(RedisKeys.USERENTER + gameid + "_" + user.getId(), 1);

        // 判断中奖次数
        Integer maxGoalTimes = (Integer) redisUtil.hget(RedisKeys.MAXGOAL + gameid, user.getLevel().toString());
        Integer userGoalTimes = (Integer) redisUtil.get(RedisKeys.USERHIT + gameid + "_" + user.getId());
        if(maxGoalTimes == null)maxGoalTimes = defaultMaxGoalTime;
        if(userGoalTimes == null){
            redisUtil.set(RedisKeys.USERHIT + gameid + "_" + user.getId(), 0);
            userGoalTimes = 0;
        }
        if(userGoalTimes >= maxGoalTimes){
            return new ApiResult<>(-1,"您已达到最大中奖数",null);
        }




        // 获取令牌
        Long token = luaScript.tokenCheck(RedisKeys.TOKENS + gameid ,String.valueOf(new Date().getTime()));
        if(token == 0){
            return new ApiResult(-1,"奖品已抽光",null);
        }else if(token == 1){
            return new ApiResult(0,"未中奖",null);
        }else{
            //token有效，中奖！
            String productKey = RedisKeys.TOKEN + gameid + "_" + token;
            CardProductDto product = (CardProductDto) redisUtil.get(productKey);
            redisUtil.incr(RedisKeys.USERHIT + gameid + "_" + user.getId(), 1);

            //mq保存中奖信息
            CardUserHit cardUserHit = new CardUserHit();
            cardUserHit.setGameid(gameid);
            cardUserHit.setHittime(now);
            cardUserHit.setUserid(user.getId());
            cardUserHit.setProductid(product.getId());
            String jsonString = JSON.toJSONString(cardUserHit);
            rabbitTemplate.convertAndSend(RabbitKeys.QUEUE_HIT, jsonString);

            return new ApiResult<>(1, "恭喜中奖", product);
        }

    }

    @GetMapping("/info/{gameid}")
    @ApiOperation(value = "查询缓存信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",example = "1",required = true)
    })
    public ApiResult info(@PathVariable int gameid){
        Map resMap = new LinkedHashMap();
        Map tokenMap = new LinkedHashMap();

        Object gameInfo = redisUtil.get(RedisKeys.INFO + gameid);
        Map<Object, Object> maxGoalMap = redisUtil.hmget(RedisKeys.MAXGOAL + gameid);
        Map<Object, Object> maxEnterMap = redisUtil.hmget(RedisKeys.MAXENTER + gameid);
        List<Object> tokenList = redisUtil.lrange(RedisKeys.TOKENS + gameid, 0, -1);


        resMap.put(RedisKeys.INFO + gameid, gameInfo);
        resMap.put(RedisKeys.MAXGOAL + gameid, maxGoalMap);
        resMap.put(RedisKeys.MAXENTER + gameid, maxEnterMap);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        for (Object item : tokenList) {
            Object o = redisUtil.get(RedisKeys.TOKEN + gameid + "_" + item.toString());
            Long key = Long.valueOf(item.toString());
            Date date = new Date(key / 1000);
            String formattedDate = dateFormat.format(date);
            tokenMap.put(formattedDate, o);
        }
        resMap.put(RedisKeys.TOKENS + gameid, tokenMap);
        return new ApiResult(200, "缓存信息", resMap);
    }

    @PostMapping("/info/{gameid}")
    @ApiOperation(value = "手动缓存信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",example = "1",required = true)
    })
    public ApiResult cache(@PathVariable int gameid){
        Map resMap = new LinkedHashMap();

        System.out.printf("scheduled!"+new Date());
        List<CardGame> gameList = gameService.list();

        // 将当前时间加一分钟
        long oneMinuteInMillis = 1 * 60 * 1000; // 一分钟的毫秒数
        Date now = new Date();
        Date newDate = new Date(now.getTime() + oneMinuteInMillis);

        List<CardGameRules> ruleList = gameRulesService.list();
        Map<Integer, List<CardGameRules>> map = new HashMap<>();
        for (CardGameRules rule : ruleList) {
            List list = map.get(rule.getGameid());
            if(list == null){
                list = new ArrayList();
            }
            list.add(rule);
            map.put(rule.getGameid(), list);
        }


        for (CardGame game : gameList) {
            if(game.getId() == gameid){
                // 缓存活动信息
                redisUtil.set(RedisKeys.INFO + game.getId(), game, -1);
                resMap.put(RedisKeys.INFO + game.getId(), game);


                // 缓存活动策略信息
                List<CardGameRules> rulesList = map.get(game.getId());
                Map maxGoalMap = new HashMap();
                Map maxEnterMap = new HashMap();
                for (CardGameRules r : rulesList) {
                    redisUtil.hset(RedisKeys.MAXGOAL + game.getId(), r.getUserlevel() + "", r.getGoalTimes());
                    redisUtil.hset(RedisKeys.MAXENTER + game.getId(), r.getUserlevel() + "", r.getEnterTimes());
                    maxGoalMap.put(r.getUserlevel(), r.getGoalTimes());
                    maxEnterMap.put(r.getUserlevel(), r.getEnterTimes());
                }
                resMap.put(RedisKeys.MAXGOAL + game.getId(), maxGoalMap);
                resMap.put(RedisKeys.MAXENTER + game.getId(), maxEnterMap);


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
                        redisUtil.set(RedisKeys.TOKEN + game.getId() + "_" + tokenList.get(idx), item, 60);
                        idx ++;
                    }
                }
                tokenList.sort(Comparator.comparing(Long::valueOf));
                redisUtil.rightPushAll(RedisKeys.TOKENS + game.getId(), tokenList);
                for (Pair<Long, CardProductDto> pair : pairList) {
                    Date date = new Date(pair.getKey() / 1000);
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
                    String formattedDate = dateFormat.format(date);
                    resMap.put(formattedDate, pair.getValue());
                }


            }
        }


        return new ApiResult(200, "缓存信息", resMap);
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
}
