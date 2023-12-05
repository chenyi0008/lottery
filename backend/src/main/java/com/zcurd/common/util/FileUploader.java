package com.zcurd.common.util;

import java.io.*;
import java.net.InetAddress;
import java.net.UnknownHostException;

import com.jfinal.kit.PropKit;
import com.jfinal.upload.UploadFile;
import io.minio.*;
import io.minio.errors.*;
import io.minio.org.apache.commons.validator.routines.InetAddressValidator;
import org.apache.commons.io.FilenameUtils;

/**
 * @ClassName: FileUploader - MinIO
 */
public class FileUploader {
    // 创建客户端
    private static MinioClient minioClient = null;
    private static final String bucket = PropKit.get("minio_bucket");
    private static String host = PropKit.get("minio_host");
    static {
        try {
            //minio的初始化存在一个小问题，endpoint必须是ip形式，不能是host
            if (!InetAddressValidator.getInstance().isValid(host)){
                System.out.println("host is not format as ip，change it！");
                InetAddress inetAddress = InetAddress.getByName(host);
                host = inetAddress.getHostAddress();
                System.out.println("host change to : " + host);
            }
            minioClient = new MinioClient(host,
                    Integer.valueOf(PropKit.get("minio_port")),
                    PropKit.get("minio_username"),
                    PropKit.get("minio_password"),false);

            System.out.println("minio connected, buckets="+minioClient.listBuckets());

            boolean found = minioClient.bucketExists(bucket);
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
            String name=System.currentTimeMillis()+"."+ FilenameUtils.getExtension(file.getFileName());


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
