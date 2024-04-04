package com.chenyi.prize.api.config;

import com.chenyi.prize.commons.context.ReqInfoContext;
import com.chenyi.prize.commons.db.entity.CardUser;
import com.chenyi.prize.commons.utils.ApiResult;
import com.chenyi.prize.commons.utils.IpUtil;
import com.chenyi.prize.commons.utils.RedisUtil;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//拦截登录失效的请求
public class RedisSessionInterceptor implements HandlerInterceptor {
    @Autowired
    private RedisUtil redisUtil;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //无论访问的地址是不是正确的，都进行登录验证，登录成功后的访问再进行分发，404的访问自然会进入到错误控制器中
        HttpSession session = request.getSession();
        if (session!= null && session.getAttribute("user")!=null) {
            CardUser user = (CardUser)session.getAttribute("user");
            ReqInfoContext.ReqInfo reqInfo = new ReqInfoContext.ReqInfo();
            reqInfo.setHost(request.getHeader("host"));
            reqInfo.setPath(request.getPathInfo());
            reqInfo.setReferer(request.getHeader("referer"));
            reqInfo.setUserAgent(request.getHeader("User-Agent"));
            reqInfo.setClientIp(IpUtil.getClientIp(request));
            reqInfo.setUser(user);
            reqInfo.setUserId(user.getId().longValue());
            ReqInfoContext.addReqInfo(reqInfo);
            return true;
        }else{
            response401(response);
            return false;
        }
    }

    private void response401(HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=utf-8");

        try {
            response.getWriter().print(JSON.toJSONString(new ApiResult(-1, "用户未登录！", null)));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
