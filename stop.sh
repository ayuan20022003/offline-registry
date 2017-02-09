#!/bin/bash
set -e
BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR
docker-compose -p offline stop 
deadids=`docker ps -aq --filter "STATUS=dead"`
if [ ! -z "$deadids" ];then
        docker rm -f $deadids
fi
