#!/bin/bash
set -e
if [  -f "../offlinesry/config.cfg" ];then
	. ../offlinesry/config.cfg
else
	. ./config.cfg
fi
if [ x"$LOCAL_IP" == x ];then
	exit 1
fi
BASE_DIR=$(cd `dirname $0` && pwd)
CONFIG_DIR="config/registry"
cd $BASE_DIR
registry_image_name=`awk '/centos7-docker-registry/{print $2}' docker-compose.yml`
if [ -f $CONFIG_DIR/config.yml ];then
	rm -rf $CONFIG_DIR/config.yml
fi
cp $CONFIG_DIR/config.yml.templ $CONFIG_DIR/config.yml && \
sed -i 's/--registry_ip--/'$LOCAL_IP'/g' $CONFIG_DIR/config.yml && \
docker images|grep $registry_image_name || docker load -i ../offline-images/registry.tar.gz && \

export COMPOSE_HTTP_TIMEOUT=300
docker-compose -p offline up -d
