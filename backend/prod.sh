mvn clean install -Dmaven.test.skip=true -P prod
nohup mvn tomcat7:run > backend.log &