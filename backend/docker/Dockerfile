FROM docker.io/library/tomcat:7
#语言字符，解决乱码问题
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
#时区及时间，不设置会影响活动的开始结束
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#将springboot的jar包打入镜像
COPY ROOT /usr/local/tomcat/webapps/ROOT
