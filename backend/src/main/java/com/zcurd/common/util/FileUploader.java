package com.zcurd.common.util;
 
import java.io.*;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.kit.PropKit;
import com.jfinal.upload.UploadFile;
import io.minio.*;
import io.minio.errors.*;
import io.minio.http.Method;
import io.minio.messages.Bucket;
import io.minio.messages.ObjectMetadata;

/**
 * @ClassName: FileUploader
 * @Author: jdh
 * @CreateTime: 2022-04-15
 * @Description: minio基本操作demo
 */
public class FileUploader {
    // 创建客户端
    private static MinioClient minioClient = null;
    private static final String bucket = PropKit.get("minio_bucket");
    static {
        minioClient = MinioClient.builder()
                .endpoint(
                        PropKit.get("minio_host"),
                        Integer.valueOf(PropKit.get("minio_port")),false)
                .credentials(PropKit.get("minio_username"), PropKit.get("minio_password"))
                .build();
        boolean found = false;
        try {
            found = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucket).build());
            if (!found) {
                // 创建桶
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucket).build());
            }
            System.out.println("MinIO:bucket init ok , bucket="+bucket);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String upload(UploadFile file){
        try {
            InputStream fileInputStream = fileInputStream = new FileInputStream(file.getFile());
            String name=System.currentTimeMillis()+".jpeg";
            ObjectWriteResponse response = minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(bucket)
                            .object(name)
                            .stream(fileInputStream, file.getFile().length(), -1) // 传入文件流和文件长度
                            .contentType("image/jpeg")
                            .build());


            String url = "http://"+PropKit.get("minio_host")+":"+PropKit.get("minio_port")
                    +"/"+bucket+"/"+name;

            System.out.println(url);

            return url;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
 