#!/bin/bash

docker network create my_net
docker pull cloudsuite/web-serving:web_server
docker pull cloudsuite/web-serving:db_server
docker pull cloudsuite/web-serving:memcached_server
docker pull cloudsuite/web-serving:faban_client

docker run -d -t --net=my_net --privileged=true --name=web_server cloudsuite/web-serving:web_server /etc/bootstrap.sh
sleep 2
docker run -d -t --net=my_net --privileged=true --name=mysql_server cloudsuite/web-serving:db_server
sleep 2
docker run -d -t --net=my_net --privileged=true --name=memcache_server cloudsuite/web-serving:memcached_server
sleep 2
docker run -d -t --net=my_net --privileged=true --name=faban_client cloudsuite/web-serving:faban_client /etc/bootstrap.sh -bash
sleep 2

exec $(pwd)/cloudsuite/benchmarks/web-serving/run.sh
