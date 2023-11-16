package com.itheima.prize.api.action;

import com.itheima.prize.api.config.LuaScript;
import com.itheima.prize.commons.config.RedisKeys;
import com.itheima.prize.commons.db.entity.CardGame;
import com.itheima.prize.commons.db.entity.CardProduct;
import com.itheima.prize.commons.db.entity.CardUserHitExample;
import com.itheima.prize.commons.db.entity.ViewCardUserHit;
import com.itheima.prize.commons.db.mapper.CardGameMapper;
import com.itheima.prize.commons.db.mapper.CardProductMapper;
import com.itheima.prize.commons.db.mapper.CardUserHitMapper;
import com.itheima.prize.commons.utils.ApiResult;
import com.itheima.prize.commons.utils.PageBean;
import com.itheima.prize.commons.utils.RedisUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/test")
@Api(tags = {"测试模块"})
public class TestController {
    private  final static Logger log = LoggerFactory.getLogger(TestController.class);
    @Autowired
    private CardGameMapper cardGameMapper;
    @Autowired
    private CardProductMapper cardProductMapper;
    @Autowired
    private RedisUtil redisUtil;
    @Autowired
    private CardUserHitMapper hitMapper;
    @Autowired
    private LuaScript luaScript;

    @GetMapping("/scale")
    @ApiOperation(value = "测试scale")
    public Object scale(){
        log.info("this a test:"+new Date());
        return "this a new test ";
    }



        @GetMapping("/luatest/{gameid}")
    @ApiOperation(value = "测试Lua脚本")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",example = "1",required = true)
    })
    public ApiResult luatest(@PathVariable int gameid){
        Long token = luaScript.tokenCheck("game_"+gameid,String.valueOf(new Date().getTime()));
        String msg = null;
        if (token == 0){
            msg = "奖池已空";
        }else if (token == 1){
            msg = "未中奖";
        }else{
            msg = "恭喜中奖";
        }
        return new ApiResult(200,msg,token);
    }


    @GetMapping("/go/{gameid}")
    @ApiOperation(value = "测试抽奖")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",example = "1",required = true)
    })
    public ApiResult acttest(@PathVariable int gameid){
        Object o = redisUtil.leftPop(RedisKeys.TOKENS+gameid);
        CardProduct product = (CardProduct) redisUtil.get(RedisKeys.TOKEN + gameid +"_"+o);
        Map map = new HashMap();
        if (o != null){
            map.put(
                    new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(new Date(Long.valueOf(o.toString())/1000)),
                    product
            );
        }
//        rabbitTemplate.convertAndSend(RabbitKeys.EXCHANGE_DIRECT,RabbitKeys.QUEUE_HIT, product);
        return new ApiResult(200,"恭喜中奖",map);
    }

    @GetMapping("/reset/{gameid}")
    @ApiOperation(value = "活动重置")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",example = "1",required = true)
    })
    public ApiResult reset(@PathVariable int gameid){
        CardGame game = cardGameMapper.selectByPrimaryKey(gameid);
        game.setStatus(0);
        game.setStarttime(DateUtils.addMinutes(new Date(),2));
        game.setEndtime(DateUtils.addMinutes(new Date(),4));
        cardGameMapper.updateByPrimaryKey(game);

        CardUserHitExample example = new CardUserHitExample();
        example.createCriteria().andGameidEqualTo(gameid);

        hitMapper.deleteByExample(example);
        return new ApiResult(200,"修改成功",game);
    }

    @GetMapping("/demo/game")
    @ApiOperation(value = "活动结构")
    public CardGame demo1(){
        return new CardGame();
    }
    @GetMapping("/demo/product")
    @ApiOperation(value = "奖品结构")
    public CardProduct demo2(){
        return new CardProduct();
    }
    @GetMapping("/demo/page")
    @ApiOperation(value = "分页结构")
    public PageBean demo3(){
        return new PageBean<Object>();
    }
    @GetMapping("/demo/hit")
    @ApiOperation(value = "中奖信息结构")
    public ViewCardUserHit demo4(){
        return new ViewCardUserHit();
    }
}
