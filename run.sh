#!/bin/bash
set -e
BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR
registry_image_name=`awk '/centos7-docker-registry/{print $2}' docker-compose.yml`
docker images|grep $registry_image_name || docker load -i ../offline-images/registry.tar.gz
docker-compose -p offline up -d
