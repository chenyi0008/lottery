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

##### 1、打包镜像

到backend下，修改db.properties，只需要修改minio的地址、端口即可，其他会直接走docker-net

执行 mvn clean package docker:build打包



到frontend下，执行 mvn clean install -DskipTests 全量编译

到api下执行 mvn docker:build打包

到msg下mvn docker:build打包



##### 2、启动

到deploy下，先用 docker-compose up 执行一下，启动后会有异常，先不管它

连上mysql，目前端口是9106，导入根目录里的prize_xxxx-xx-xx.sql，用最新的！



停掉服务： docker-compose down

再次启动： docker-compose up -d ，将会启动正常



##### 3、访问

管理后台：9103

api接口：9102 ， /doc.html

minio控制台：9006  ， minioadmin /  minioadmin

mysql: 9106

nginx: 9101
