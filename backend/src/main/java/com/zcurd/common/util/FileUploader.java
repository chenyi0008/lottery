package com.zcurd.common.util;

import java.io.*;
import com.jfinal.kit.PropKit;
import com.jfinal.upload.UploadFile;
import io.minio.*;
import io.minio.errors.*;

/**
 * @ClassName: FileUploader - MinIO
 */
public class FileUploader {
    // 创建客户端
    private static MinioClient minioClient = null;
    private static final String bucket = PropKit.get("minio_bucket");
    static {
        try {
            minioClient = new MinioClient(PropKit.get("minio_host"),
                    Integer.valueOf(PropKit.get("minio_port")),
                    PropKit.get("minio_username"),
                    PropKit.get("minio_password"),false);
        } catch (InvalidEndpointException e) {
            throw new RuntimeException(e);
        } catch (InvalidPortException e) {
            throw new RuntimeException(e);
        }


        boolean found = false;
        try {
            found = minioClient.bucketExists(bucket);
            if (!found) {
                // 创建桶
                minioClient.makeBucket(bucket);
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

            minioClient.putObject(
                    bucket,name,new FileInputStream(file.getFile()),file.getFile().length(),null,null, file.getContentType()
            );

            String url = PropKit.get("minio_url")
                    +"/"+bucket+"/"+name;

            System.out.println(url);

            return url;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
