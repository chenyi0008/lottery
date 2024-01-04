package com.ruoyi.web.core.config;

import io.minio.MinioClient;
import io.minio.org.apache.commons.validator.routines.InetAddressValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;

import java.net.InetAddress;

@Configuration
@ConfigurationProperties(prefix = "minio")
public class MinioConfig {
    final static Logger logger = LoggerFactory.getLogger(MinioConfig.class);
    
    private static String host;
    private static String port;
    private static String bucket;
    private static String username;
    private static String password;
    private static String url;

    @Bean
    @Lazy
//    @ConditionalOnProperty(name = "ruoyi.uploadType", havingValue = "minio")
    public MinioClient minioClient() throws Exception {
        //minio的初始化存在一个小问题，endpoint必须是ip形式，不能是host
        if (!InetAddressValidator.getInstance().isValid(host)){
            logger.warn("MinIO:host is not format as ip，change it！");
            InetAddress inetAddress = InetAddress.getByName(host);
            host = inetAddress.getHostAddress();
            logger.info("MinIO:host change to : {}" , host);
        }
        MinioClient minioClient = new MinioClient(host,
                Integer.valueOf(port),
                username,
                password,false);

//        logger.info("minio connected, buckets="+minioClient.listBuckets());

        boolean found = minioClient.bucketExists(bucket);
        if (!found) {
            // 创建桶
            minioClient.makeBucket(bucket);
        }
        logger.info("MinIO:bucket init ok , bucket={}" , bucket);
        return minioClient;
    }


    public static String getHost() {
        return host;
    }

    public static String getPort() {
        return port;
    }

    public static String getBucket() {
        return bucket;
    }

    public static String getUsername() {
        return username;
    }

    public static String getPassword() {
        return password;
    }

    public static String getUrl() {
        return url;
    }

    public void setHost(String host) {
        MinioConfig.host = host;
    }

    public void setPort(String port) {
        MinioConfig.port = port;
    }

    public void setBucket(String bucket) {
        MinioConfig.bucket = bucket;
    }

    public void setUsername(String username) {
        MinioConfig.username = username;
    }

    public void setPassword(String password) {
        MinioConfig.password = password;
    }

    public void setUrl(String url) {
        MinioConfig.url = url;
    }
}