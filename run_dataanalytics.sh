#!/bin/bash

docker pull cloudsuite/in-memory-analytics
docker pull cloudsuite/movielens-dataset

docker create --name data cloudsuite/movielens-dataset
docker run --rm --volumes-from data cloudsuite/in-memory-analytics  /data/ml-latest /data/myratings.csv --driver-memory 4g --executor-memory 4g
