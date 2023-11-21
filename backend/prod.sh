mvn clean install -Dmaven.test.skip=true
ps aux | grep 'tomcat7:run' | grep -v grep | awk '{print $2}' | xargs kill -9
nohup mvn tomcat7:run > backend.log &