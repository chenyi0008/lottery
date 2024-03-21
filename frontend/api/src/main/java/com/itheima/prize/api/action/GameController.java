package com.itheima.prize.api.action;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itheima.prize.commons.db.entity.CardGame;
import com.itheima.prize.commons.db.entity.CardProductDto;
import com.itheima.prize.commons.db.entity.ViewCardUserHit;
import com.itheima.prize.commons.db.mapper.CardGameMapper;
import com.itheima.prize.commons.db.mapper.GameLoadMapper;
import com.itheima.prize.commons.db.mapper.ViewCardUserHitMapper;
import com.itheima.prize.commons.db.service.CardGameService;
import com.itheima.prize.commons.db.service.GameLoadService;
import com.itheima.prize.commons.db.service.ViewCardUserHitService;
import com.itheima.prize.commons.utils.ApiResult;
import com.itheima.prize.commons.utils.PageBean;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.smartcardio.Card;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping(value = "/api/game")
@Api(tags = {"活动模块"})
public class GameController {
    @Autowired
    private GameLoadService loadService;
    @Autowired
    private CardGameService gameService;
    @Autowired
    private ViewCardUserHitService hitService;

    @GetMapping("/list/{status}/{curpage}/{limit}")
    @ApiOperation(value = "活动列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name="status",value = "活动状态（-1=全部，0=未开始，1=进行中，2=已结束）",example = "-1",required = true),
            @ApiImplicitParam(name = "curpage",value = "第几页",defaultValue = "1",dataType = "int", example = "1",required = true),
            @ApiImplicitParam(name = "limit",value = "每页条数",defaultValue = "10",dataType = "int",example = "3",required = true)
    })
    public ApiResult list(@PathVariable int status,@PathVariable int curpage,@PathVariable int limit) {
        LambdaQueryWrapper<CardGame> lqw = new LambdaQueryWrapper<>();
        if(status != -1){
            lqw.eq(CardGame::getStatus, status);
        }
        Page<CardGame> page = gameService.page(new Page<>(curpage, limit), lqw);
        return new ApiResult(1, "成功", new PageBean<>(page));
    }

    @GetMapping("/info/{gameid}")
    @ApiOperation(value = "活动信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",example = "1",required = true)
    })
    public ApiResult<CardGame> info(@PathVariable int gameid) {
        CardGame res = gameService.getById(gameid);
        return new ApiResult(1, "成功", res);
    }

    @GetMapping("/products/{gameid}")
    @ApiOperation(value = "奖品信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",example = "1",required = true)
    })
    public ApiResult<List<CardProductDto>> products(@PathVariable int gameid) {
        List<CardProductDto> res = loadService.getByGameId(gameid);
        return new ApiResult(1, "成功", res);
    }

    @GetMapping("/hit/{gameid}/{curpage}/{limit}")
    @ApiOperation(value = "中奖列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id",dataType = "int",example = "1",required = true),
            @ApiImplicitParam(name = "curpage",value = "第几页",defaultValue = "1",dataType = "int", example = "1",required = true),
            @ApiImplicitParam(name = "limit",value = "每页条数",defaultValue = "10",dataType = "int",example = "3",required = true)
    })
    public ApiResult hit(@PathVariable int gameid,@PathVariable int curpage,@PathVariable int limit) {
        LambdaQueryWrapper<CardGame> lqw = new LambdaQueryWrapper<>();
        lqw.eq(CardGame::getId, gameid);
        Page<CardGame> page = gameService.page(new Page<>(curpage, limit), lqw);
        return new ApiResult(1, "成功", new PageBean<>(page));
    }


}