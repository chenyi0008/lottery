package com.chenyi.prize.api.action;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.chenyi.prize.commons.db.entity.CardUser;
import com.chenyi.prize.commons.db.service.CardUserService;
import com.chenyi.prize.commons.utils.ApiResult;
import com.chenyi.prize.commons.utils.PasswordUtil;
import com.chenyi.prize.commons.utils.RedisUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping(value = "/api")
@Api(tags = {"登录模块"})
public class LoginController {
    @Autowired
    private CardUserService userService;

    @Autowired
    private RedisUtil redisUtil;

    static private String loginPrefix = "login account:";
    static private String UserInfoPrefix = "user";

    @PostMapping("/login")
    @ApiOperation(value = "登录")
    @ApiImplicitParams({
            @ApiImplicitParam(name="account",value = "用户名",required = true),
            @ApiImplicitParam(name="password",value = "密码",required = true)
    })
    public ApiResult login(HttpServletRequest request, @RequestParam String account,@RequestParam String password) {
        HttpSession session = request.getSession();
        Integer loginTimes = (Integer)redisUtil.get(loginPrefix + account);
        if (loginTimes != null && loginTimes >= 5)return new ApiResult(0, "密码错误5次，请5分钟后再登录", null);

        LambdaQueryWrapper<CardUser> lqw = new LambdaQueryWrapper<>();
        lqw.eq(CardUser::getUname, account);
        CardUser user = userService.getOne(lqw);
        String encryptPassword = PasswordUtil.encodePassword(password);
        if(user == null || !user.getPasswd().equals(encryptPassword)){
            if(loginTimes == null)redisUtil.set(loginPrefix + account, 1, 5 * 60);
            else redisUtil.set(loginPrefix + account, loginTimes + 1, 5 * 60);
            return new ApiResult(0, "账户名或密码错误", null);
        }
        user.setPasswd(null);
        session.setAttribute(UserInfoPrefix, user);
        return new ApiResult<>(1, "登录成功", user);


    }

    @GetMapping("/logout")
    @ApiOperation(value = "退出")
    public ApiResult logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute(UserInfoPrefix, null);
        return new ApiResult<>(1, "退出成功", null);
    }

}