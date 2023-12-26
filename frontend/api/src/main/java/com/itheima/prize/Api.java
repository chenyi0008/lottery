package com.itheima.prize;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
@MapperScan("com.itheima.prize.commons.db.mapper")
@EnableCaching
@EnableRedisHttpSession(maxInactiveIntervalInSeconds = -1)
public class Api {

    public static void main(String[] args) {
        new SpringApplicationBuilder(Api.class).run(args);
    }




}