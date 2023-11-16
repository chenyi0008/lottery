package com.itheima.prize.api.action;

import com.itheima.prize.api.config.LuaScript;
import com.itheima.prize.commons.config.RabbitKeys;
import com.itheima.prize.commons.config.RedisKeys;
import com.itheima.prize.commons.db.entity.*;
import com.itheima.prize.commons.db.mapper.CardGameMapper;
import com.itheima.prize.commons.db.mapper.CardUserGameMapper;
import com.itheima.prize.commons.utils.ApiResult;
import com.itheima.prize.commons.utils.RedisUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("/api/act")
@Api(tags = {"抽奖模块"})
public class ActController {

    @Autowired
    private CardGameMapper cardGameMapper;
    @Autowired
    private RedisUtil redisUtil;
    @Autowired
    private RabbitTemplate rabbitTemplate;
    @Autowired
    private LuaScript luaScript;

    @GetMapping("/go/{gameid}")
    @ApiOperation(value = "抽奖")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",example = "1",required = true)
    })
    public ApiResult<Object> act(@PathVariable int gameid, HttpServletRequest request){
        Date now = new Date();
        //获取活动基本信息
        CardGame game = (CardGame) redisUtil.get(RedisKeys.INFO+gameid);
        //判断活动是否开始
        //如果活动信息还没加载进redis，无效
        //如果活动已经加载，预热完成，但是开始时间 > 当前时间，也无效
        if (game == null || game.getStarttime().after(now)){
            return new ApiResult(-1,"活动未开始",null);
        }
        //判断活动是否已结束
        if (now.after(game.getEndtime())){
            return new ApiResult(-1,"活动已结束",null);
        }
        //获取当前用户
        HttpSession session = request.getSession();
        CardUser user = (CardUser) redisUtil.get(RedisKeys.SESSIONID+session.getId());
        if (user == null){
            return new ApiResult(-1,"未登陆",null);
        }else{
            //第一次抽奖，发送消息队列，用于记录参与的活动（redis分布式锁）
            if (!redisUtil.hasKey(RedisKeys.USERGAME+user.getId()+"_"+gameid)){
                redisUtil.set(RedisKeys.USERGAME+user.getId()+"_"+gameid,1,(game.getEndtime().getTime() - now.getTime())/1000);
                //持久化抽奖记录，扔给消息队列处理
                CardUserGame userGame = new CardUserGame();
                userGame.setUserid(user.getId());
                userGame.setGameid(gameid);
                userGame.setCreatetime(new Date());
                rabbitTemplate.convertAndSend(RabbitKeys.QUEUE_PLAY,userGame);
            }
        }

        //用户可抽奖次数
        Integer enter = (Integer) redisUtil.get(RedisKeys.USERENTER+gameid+"_"+user.getId());
        if (enter == null){
            enter = 0;
            redisUtil.set(RedisKeys.USERENTER+gameid+"_"+user.getId(),enter,(game.getEndtime().getTime() - now.getTime())/1000);
        }
        //根据会员等级，获取本活动允许的最大抽奖次数
        Integer maxenter = (Integer) redisUtil.hget(RedisKeys.MAXENTER+gameid,user.getLevel()+"");
        //如果没设置，默认为0，即：不限制次数
        maxenter = maxenter==null ? 0 : maxenter;
        //次数对比
        if (maxenter > 0 && enter >= maxenter){
            //如果达到最大次数，不允许抽奖
            return new ApiResult(-1,"您的抽奖次数已用完",null);
        }else{
            redisUtil.incr(RedisKeys.USERENTER+gameid+"_"+user.getId(),1);
        }


        //用户已中奖次数
        Integer count = (Integer) redisUtil.get(RedisKeys.USERHIT+gameid+"_"+user.getId());
        if (count == null){
            count = 0;
            redisUtil.set(RedisKeys.USERHIT+gameid+"_"+user.getId(),count,(game.getEndtime().getTime() - now.getTime())/1000);
        }
        //根据会员等级，获取本活动允许的最大中奖数
        Integer maxcount = (Integer) redisUtil.hget(RedisKeys.MAXGOAL+gameid,user.getLevel()+"");
        //如果没设置，默认为0，即：不限制次数
        maxcount = maxcount==null ? 0 : maxcount;
        //次数对比
        if (maxcount > 0 && count >= maxcount){
            //如果达到最大次数，不允许抽奖
            return new ApiResult(-1,"您已达到最大中奖数",null);
        }


        //以上校验全部过关，进入下一步：拿token
        //也就是决定中不中最关键的一步，拿到合法token就中奖
        Long token;
        switch (game.getType()) {
            //时间随机
            case 1:
                //随即类比较麻烦，按设计时序图走

                //java调redis，有原子性问题！
//                token = (Long) redisUtil.leftPop(RedisKeys.TOKENS+gameid);
//                if (token == null){
//                    //令牌已用光，说明奖品抽光了
//                    return new ApiResult(-1,"奖品已抽光",null);
//                }
//                //判断令牌时间戳大小，即是否中奖
//                //这里记住，取出的令牌要除以1000，参考job项目，令牌生成部分
//                if (now.getTime() < token/1000){
//                    //当前时间小于令牌时间戳，说明奖品未到发放时间点，放回令牌，返回未中奖
//                    redisUtil.leftPush(RedisKeys.TOKENS+gameid,token);
//                    return new ApiResult(0,"未中奖",null);
//                }


                //lua调redis
                token = luaScript.tokenCheck(RedisKeys.TOKENS+gameid,String.valueOf(new Date().getTime()));
                if(token == 0){
                    return new ApiResult(-1,"奖品已抽光",null);
                }else if(token == 1){
                    return new ApiResult(0,"未中奖",null);
                }

                break;

            case 2:

                //瞬间秒杀类简单，直接获取令牌，有就中，没有就说明抢光了
                token = (Long) redisUtil.leftPop(RedisKeys.TOKENS+gameid);
                if (token == null){
                    //令牌已用光，说明奖品抽光了
                    return new ApiResult(-1,"奖品已抽光",null);
                }

                break;

            case 3:

                //幸运转盘类，先给用户随机剔除，再获取令牌，有就中，没有就说明抢光了
                //一般这种情况会设置足够的商品，卡在随机上
                Integer randomRate = (Integer) redisUtil.hget(RedisKeys.RANDOMRATE+gameid,user.getLevel()+"");
                if (randomRate == null){
                    randomRate = 100;
                }
                //注意这里的概率设计思路：
                //每次请求取一个0-100之间的随机数，如果这个数没有落在范围内，直接返回未中奖
                if( new Random().nextInt(100) > randomRate ){
                    return new ApiResult(0,"未中奖",null);
                }

                token = (Long) redisUtil.leftPop(RedisKeys.TOKENS+gameid);
                if (token == null){
                    //令牌已用光，说明奖品抽光了
                    return new ApiResult(-1,"奖品已抽光",null);
                }

                break;

            default:
                return new ApiResult(0,"不支持的活动类型",null);

        }//end switch


        //以上逻辑走完，拿到了合法的token，说明很幸运，中奖了！
        //抽中的奖品：
        CardProduct product = (CardProduct) redisUtil.get(RedisKeys.TOKEN + gameid +"_"+token);
        //中奖次数加1
        redisUtil.incr(RedisKeys.USERHIT+gameid+"_"+user.getId(),1);
        //投放消息给队列，中奖后的耗时业务，交给消息模块处理
        CardUserHit hit = new CardUserHit();
        hit.setGameid(gameid);
        hit.setHittime(now);
        hit.setProductid(product.getId());
        hit.setUserid(user.getId());
        rabbitTemplate.convertAndSend(RabbitKeys.EXCHANGE_DIRECT,RabbitKeys.QUEUE_HIT, hit);

        //返回给前台中奖信息
        return new ApiResult(1,"恭喜中奖",product);
    }

    @GetMapping("/info/{gameid}")
    @ApiOperation(value = "缓存信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",example = "1",required = true)
    })
    public ApiResult info(@PathVariable int gameid){
        Map map = new LinkedHashMap<>();
        map.put(RedisKeys.INFO+gameid,redisUtil.get(RedisKeys.INFO+gameid));
        List<Object> tokens = redisUtil.lrange(RedisKeys.TOKENS+gameid,0,-1);
        Map tokenMap =new LinkedHashMap();
        tokens.forEach(o -> tokenMap.put(
                new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date(Long.valueOf(o.toString())/1000)),
                redisUtil.get(RedisKeys.TOKEN + gameid +"_"+o))
        );
        map.put(RedisKeys.TOKENS+gameid,tokenMap);
        map.put(RedisKeys.MAXGOAL+gameid,redisUtil.hmget(RedisKeys.MAXGOAL+gameid));
        map.put(RedisKeys.MAXENTER+gameid,redisUtil.hmget(RedisKeys.MAXENTER+gameid));
        return new ApiResult(200,"缓存信息",map);
    }
}
