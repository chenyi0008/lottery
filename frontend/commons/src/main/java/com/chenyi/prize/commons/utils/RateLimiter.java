package com.chenyi.prize.commons.utils;

import org.springframework.core.io.ClassPathResource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.core.script.RedisScript;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Collections;

/**
 * @Description
 * @Author chenyi0008
 * @Date 2024/4/7
 */
@Component
public class RateLimiter {
    static private String pathResource = "lua/token_bucket_current_limiter.lua";
    private StringRedisTemplate redisTemplate;
    private RedisScript<Long> rateLimitScript;

    public RateLimiter(StringRedisTemplate redisTemplate) throws IOException {
        this.redisTemplate = redisTemplate;
        String luaScript = buildLuaScript();
        this.rateLimitScript = new DefaultRedisScript<>(luaScript, Long.class);
    }

    /**
     * 限流器
     *
     * @param key                   限流器的唯一标识键
     * @param intervalPerTokens     每个令牌生成的时间间隔（毫秒）
     * @param curTime               当前时间戳（毫秒）
     * @param initTokens            限流器初始化时的令牌数量
     * @param bucketMaxTokens       限流器桶的最大令牌容量
     * @param resetBucketInterval   重置限流器桶的时间间隔（毫秒）
     * @return                      返回剩余的令牌数，0 表示限流，大于 0 表示还有可用令牌
     */
    public long rateLimit(String key, long intervalPerTokens, long curTime, long initTokens, long bucketMaxTokens, long resetBucketInterval) {
        return redisTemplate.execute(rateLimitScript, Collections.singletonList(key), String.valueOf(intervalPerTokens), String.valueOf(curTime), String.valueOf(initTokens), String.valueOf(bucketMaxTokens), String.valueOf(resetBucketInterval));
    }

    private static String buildLuaScript() throws IOException {
        // 创建一个类路径资源对象，指定要读取的文件路径
        ClassPathResource resource = new ClassPathResource(pathResource);

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
        return contentBuilder.toString();
    }

}
