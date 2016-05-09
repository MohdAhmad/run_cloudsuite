#!/bin/bash

docker exec -t mongodb-bench bash -c "cd /usr/local/ycsb-0.5.0 ;
./bin/ycsb run mongodb-async -s -P workloads/workloadb > outputRun.txt -p operationcount=4000000"
