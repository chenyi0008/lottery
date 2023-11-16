# 企业红包雨

#### 介绍
企业红包雨项目


#### 安装教程

1·准备好数据库，redis，rabbitmq，可以自己安装，可以参考docker脚本使用docker方式

2·链接数据库，导入prize.sql脚本，初始化数据库

3·backend为后台，使用 mvn tomcat7:run 启动

4·frontend为前台接口，springboot方式启动 api ， msg

5·访问api的 /doc.html 可以看到swagger的入口

6·部署nginx，可以本地，可以docker，启动后访问即可参与抽奖



