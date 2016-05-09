#!/bin/bash

#Scales twitter dataset to 10x=3GB and send 10k requests/second.

docker network create caching_network

docker pull cloudsuite/data-caching:server
docker pull mohdahmad/data-caching:client

docker run --name dc-server --net caching_network -d cloudsuite/data-caching:server -t 4 -m 4096 -n 550

docker run -t -d --name dc-client --net caching_network mohdahmad/data-caching:client bash
sleep 1
docker exec -t dc-client bash -c "cd /usr/src/memcached/memcached_client/; ./loader -a ../twitter_dataset/twitter_dataset_10x -s docker_servers.txt -g 0.8 -T 10 -c 200 -w 8 -e -r 10000"

