mvn clean install -Dmaven.test.skip=true

ps aux | grep api-0.0.1-SNAPSHOT | grep -v grep |awk '{print $2}' | xargs kill -9
nohup java -jar api/target/api-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod > api.log &

ps aux | grep msg-0.0.1-SNAPSHOT | grep -v grep |awk '{print $2}' | xargs kill -9
nohup java -jar msg/target/msg-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod > msg.log &
