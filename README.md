# 企业红包雨

#### 介绍
企业红包雨项目


#### 本地启动教程

1·准备好数据库，redis，rabbitmq，可以自己安装，可以参考docker脚本使用docker方式

2·链接数据库，导入prize.sql脚本，初始化数据库

3·backend为后台，使用 mvn tomcat7:run 启动

4·frontend为前台接口，springboot方式启动 api ， msg

5·访问api的 /doc.html 可以看到swagger的入口

6·部署nginx，可以本地，可以docker，启动后访问即可参与抽奖



#### 服务器一键启动（docker-compose）

代码中的deploy文件夹下已经集成了docker-compose一键部署

确保：

1、将代码打包拷贝到服务器，或者直接从服务器上 git clone

2、服务器上安装了docker及docker-compose



##### 1、打包镜像

====> 到backend下：

执行 mvn clean package docker:build 编译并打包



====> 到frontend下：

执行 mvn clean install -DskipTests 全量编译

到api下执行 mvn docker:build打包

到msg下mvn docker:build打包



##### 2、启动并初始化

====> 到deploy下：

只需要修改一个配置项：docker-compose里minio的外部访问地址，修改ip为你的机器ip

其他配置均为Docker内部网络，不要修改！不要修改！不要修改！

![image-20240102下午64926541](pic//image-20240102%E4%B8%8B%E5%8D%8864926541.png)



先用 docker-compose up lottery-mysql lottery-minio 执行一下，启动Mysql和Minio

（1）用客户端工具连上mysql，目前端口是9007，创建prize数据库，导入根目录里的prize_xxxx-xx-xx.sql到prize数据库，用最新的！

（2）访问9006的minio控制台，创建prize的桶，并在Buckets - prize桶 - Anonymous下，

点击Add Access Rule按钮，Prefix设置成  /  ,  Access可以是ReadOnly，否则url访问会403

![image-20231205下午32314888](pic//image-20231205%E4%B8%8B%E5%8D%8832314888.png)



重启服务： docker-compose up -d ，将会后台启动全部服务



##### 3、访问

minio访问：9005

minio控制台：9006  ， minioadmin /  minioadmin

mysql: 9007

rabbitmq控制台：9008
rabbitmq消息：9009

redis：9010



nginx: 9101

api接口：9102 ， /doc.html

管理后台：9103



其他端口如redis可以自行改为不对外暴露，直接程序走docker-network内链接



备注：docker-compose里的端口可以根据自己情况修改
