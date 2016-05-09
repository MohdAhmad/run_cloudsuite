#!/bin/bash

MONGO_PID=$(ps axj | grep mongod | awk '$10=="./bin/mongod" {print $2}')
YCSB_PID=$(ps axj | grep ycsb | awk '$10=="java" {print $2}')

sudo perf stat -e cycles -I 2000 -p $MONGO_PID,$YCSB_PID 

#monitor the spark threads
#sudo perf stat -e cycles -I 2000 -p $(ps axjf | grep -m 1 spark-1.5.1 | awk '{print $2}')

#monitor memcached threads    
#SERVER_PID=$(ps axj | grep memcache | awk '$10!="grep" {print $2}')
#CLIENT_PID=$(ps axj | grep loader | awk '$10!="grep" {print $2}')
#echo $SERVER_PID
#echo $CLIENT_PID
#perf stat -e cycles -I 2000 -p $SERVER_PID,$CLIENT_PID

#sudo perf stat -e cycles -I 2000 -p $(ps axjf | awk '$8!=1000' | grep -m 1 memcached | awk '{print $2}'),$(ps axjf | awk '$8!=1000' | grep -m 1 loader | awk '{print $2}')


#monitor webserver application
#SERVER_PIDS=""
#PIDS=$(ps axj | grep "nginx: worker" | awk '$10!="grep" {print $2}')
#
#for pid in $PIDS; do
#    SERVER_PIDS+=$pid","
#done
#echo "SERVER_PIDS:" $SERVER_PIDS
#
#PHP_PIDS=""
#PIDS=$(ps axj | grep "php-fpm: pool" | awk '$10!="grep" {print $2}')
#
#for pid in $PIDS; do
#    PHP_PIDS+=$pid","
#done
#echo "PHP_PIDS:" $PHP_PIDS
#
#MEMCACHED_PID=$(ps axj | grep "memcached" | awk '{if ($10=="memcached") print $2}')
#echo "MEMCACHED_PID:" $MEMCACHED_PID
#
#
#MYSQL_PID=$(ps axj | grep "mysql" | awk '{if ($10!="grep") print $2}')
#echo "MYSQL_PID:" $MYSQL_PID
#
#CLIENT_PIDS=$(ps axj | grep DisableExplicitGC | awk '$10!="grep" {print $2}')
#CLIENT_PIDS+=","$(ps axj | grep Xms64m | awk '$10!="grep" {print $2}')
#echo "CLIENT_PIDS:" $CLIENT_PIDS
#
#ALL_PIDS=$SERVER_PIDS$PHP_PIDS$MEMCACHED_PID","$MYSQL_PID","$CLIENT_PIDS
#echo "ALL_PIDS:" $ALL_PIDS
#
#sudo perf stat -e cycles -I 2000 -p $PHD_PIDS 
