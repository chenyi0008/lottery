package com.chenyi.prize.commons.aspect;

import com.chenyi.prize.commons.annotition.limit.Limit;
import com.chenyi.prize.commons.annotition.limit.LimitType;
import com.chenyi.prize.commons.context.ReqInfoContext;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.core.script.RedisScript;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

/**
 * 限流规则：计数器限流
 * limit.period() 计数器时间
 * limit.count()  最大请求次数
 */
@Aspect
@Component
public class LimitAspect {

    private final StringRedisTemplate redisTemplate;
    private static final Logger logger = LoggerFactory.getLogger(LimitAspect.class);
    private static final String PREFIX = "LIMIT_";
    private static String lua;

    public LimitAspect(StringRedisTemplate redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Pointcut("@annotation(com.chenyi.prize.commons.annotition.limit.Limit)")
    public void pointcut() {
    }

    @Around("pointcut()")
    public Object around(ProceedingJoinPoint point) throws Throwable {
        MethodSignature signature = (MethodSignature) point.getSignature();
        Method signatureMethod = signature.getMethod();
        Limit limit = signatureMethod.getAnnotation(Limit.class);

        String key = getCombinKey(limit, signatureMethod);
        List<String> keys = Collections.singletonList(key);

        String luaScript = buildLuaScript();
        RedisScript<Long> redisScript = new DefaultRedisScript<>(luaScript, Long.class);

        Long count = redisTemplate.execute(redisScript, keys, String.valueOf(limit.count()), String.valueOf(limit.period()));
        if (null != count && count.intValue() <= limit.count()) {
            logger.info("第{}次访问key为 {}，描述为 [{}] 的接口", count, keys, limit.name());
            return point.proceed();
        } else {
            throw new Exception("访问过于频繁");
        }
    }

    private String getCombinKey(Limit limit, Method signatureMethod) {
        // combinKey = 资源key + 用户key
        StringBuilder combinKey = new StringBuilder(PREFIX);

        // 资源key
        String key = limit.key();
        combinKey.append(key).append("_");

        // 用户key
        LimitType limitType = limit.limitType();
        switch (limitType) {
            case CUSTOMER:
                combinKey.append(ReqInfoContext.getReqInfo().getUserId());
                break;
            case IP:
                combinKey.append(ReqInfoContext.getReqInfo().getClientIp());
                break;
            default:
                break;
        }
        return combinKey.toString();
    }

        /**
     * 限流脚本
     */
        public static String buildLuaScript() throws IOException {
            if(lua != null)return lua;

            // 创建一个类路径资源对象，指定要读取的文件路径
            ClassPathResource resource = new ClassPathResource("lua/limit.lua");

            // 通过类路径资源对象获取输入流
            InputStream inputStream = resource.getInputStream();

            // 创建一个缓冲字符输入流，用于读取文件内容
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));

            // 创建一个StringBuilder对象，用于存储文件内容
            StringBuilder contentBuilder = new StringBuilder();
            String line;

            // 逐行读取文件内容并添加到StringBuilder对象中
            while ((line = reader.readLine()) != null) {
                contentBuilder.append(line).append("\n");
            }

            // 关闭流
            reader.close();
            inputStream.close();

            // 将StringBuilder对象中的内容转换为字符串并返回
            lua = contentBuilder.toString();
            return lua;
        }

//    /**
//     * 限流脚本
//     */
//    private String buildLuaScript() {
//        return """
//                local key = KEYS[1]
//                local limitCount = tonumber(ARGV[1])
//                local limitTime = tonumber(ARGV[2])
//
//                local currentCount = redis.call('get',key)
//                if type(currentCount) == "number" and tonumber(currentCount) > limitCount then
//                    return tonumber(currentCount)
//                end
//
//                currentCount = redis.call("incr",key)
//                if tonumber(currentCount) == 1 then
//                    redis.call("expire",key,limitTime)
//                end
//                return tonumber(currentCount)
//                """;
//    }

//    private String buildLuaScript() {return "";}
}
