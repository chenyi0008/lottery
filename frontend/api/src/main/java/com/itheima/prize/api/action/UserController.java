package com.itheima.prize.api.action;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itheima.prize.commons.db.entity.CardGame;
import com.itheima.prize.commons.db.entity.CardUser;
import com.itheima.prize.commons.db.entity.CardUserDto;
import com.itheima.prize.commons.db.entity.ViewCardUserHit;
import com.itheima.prize.commons.db.mapper.ViewCardUserHitMapper;
import com.itheima.prize.commons.db.service.GameLoadService;
import com.itheima.prize.commons.db.service.ViewCardUserHitService;
import com.itheima.prize.commons.utils.ApiResult;
import com.itheima.prize.commons.utils.PageBean;
import com.itheima.prize.commons.utils.RedisUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping(value = "/api/user")
@Api(tags = {"用户模块"})
public class UserController {

    @Autowired
    private RedisUtil redisUtil;
    @Autowired
    private ViewCardUserHitService hitService;
    @Autowired
    private GameLoadService loadService;

    static private String UserInfoPrefix = "user";

    @GetMapping("/info")
    @ApiOperation(value = "用户信息")
    public ApiResult info(HttpServletRequest request) {
        CardUser userInfo = (CardUser)request.getSession().getAttribute(UserInfoPrefix);
        CardUserDto userDto = new CardUserDto();
        BeanUtils.copyProperties(userInfo, userDto);
        userDto.setGames(loadService.getGamesNumByUserId(userInfo.getId()));
        userDto.setProducts(loadService.getPrizesNumByUserId(userDto.getId()));
        return new ApiResult(1, "成功", userDto);
    }

    @GetMapping("/hit/{gameid}/{curpage}/{limit}")
    @ApiOperation(value = "我的奖品")
    @ApiImplicitParams({
            @ApiImplicitParam(name="gameid",value = "活动id（-1=全部）",dataType = "int",example = "1",required = true),
            @ApiImplicitParam(name = "curpage",value = "第几页",defaultValue = "1",dataType = "int", example = "1"),
            @ApiImplicitParam(name = "limit",value = "每页条数",defaultValue = "10",dataType = "int",example = "3")
    })
    public ApiResult hit(@PathVariable int gameid,@PathVariable int curpage,@PathVariable int limit,HttpServletRequest request) {
        LambdaQueryWrapper<ViewCardUserHit> lqw = new LambdaQueryWrapper<>();
        if (gameid != -1)lqw.eq(ViewCardUserHit::getGameid, gameid);
        Page<ViewCardUserHit> page = hitService.page(new Page<>(curpage, limit), lqw);
        return new ApiResult(1, "成功", new PageBean<ViewCardUserHit>(page));
    }


}