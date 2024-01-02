FROM anapsix/alpine-java:8_server-jre_unlimited
#语言字符，解决乱码问题
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
#时区及时间，不设置会影响活动的开始结束
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#将springboot的jar包打入镜像
COPY backend-0.0.1-SNAPSHOT.jar /opt/ROOT.jar
WORKDIR /opt
#启动命令
CMD sleep 20;java -Djava.security.egd=file:/dev/./urandom -jar ROOT.jar