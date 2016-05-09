#!/bin/bash

docker pull mohdahmad/mongodb-test:0.2

docker run --name mongodb-bench -d -t mohdahmad/mongodb-test:0.2 
echo "Launched container"

docker exec -t -d mongodb-bench bash -c "cd /home/mongodb-linux-x86_64-3.2.6 ; ./bin/mongod --dbpath /tmp/mongodb"
echo "Launched MongoDb"

sleep 5

docker exec -t mongodb-bench bash -c "cd /usr/local/ycsb-0.5.0 ; ./bin/ycsb load mongodb-async -s -P workloads/workloadb > outputLoad1.txt -p recordcount=833333 -p mongodb.upsert=true" 
echo "Loaded data"

#root@4246e41f4f2e:/usr/local/ycsb-0.5.0# ./bin/ycsb load mongodb-async -s -P workloads/workloadb > outputLoad1.txt -p recordcount=833333 -p mongodb.upsert=true

#root@4246e41f4f2e:/usr/local/ycsb-0.5.0# ./bin/ycsb run mongodb-async -s -P workloads/workloadb > outputRun.txt -p operationcount=833333  

#scalegrid.io/blog/how-to-benchmark-mongodb-with-ycsb/
