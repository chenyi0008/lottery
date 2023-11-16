#redis
docker run --name redis -p 6379:6379 -d daocloud.io/library/redis

#mysql
docker run --name mysql -v /opt/data/mysql:/var/lib/mysql -p3306:3306 -e MYSQL_ROOT_PASSWORD=password -d daocloud.io/mysql:5.7.4

#rabbitmq
docker run -d --hostname my-rabbit --name rabbit -p 15672:15672 -p 5672:5672 daocloud.io/library/rabbitmq:3.6.10-management

#nginx
docker run --name nginx -v /opt/data/nginx/h5:/usr/share/nginx/html:ro -v /opt/app/back/upload:/usr/share/nginx/upload:ro -v /opt/data/nginx/nginx.conf:/etc/nginx/nginx.conf:ro -p 80:80 -d daocloud.io/nginx

