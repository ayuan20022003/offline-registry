#!/bin/bash
set -e
BASE_DIR=$(cd `dirname $0` && pwd)
CONFIG_DIR="config/registry"
cd $BASE_DIR
if [  -f "../offlinesry/config.cfg" ];then
	. ../offlinesry/config.cfg
elif [ -f "../offline-dmos/config.cfg" ]; then
	. ../offline-dmos/config.cfg
elif [ -f "../config.cfg" ];then
        . ../config.cfg
else
	. ./config.cfg
fi
if [ x"$LOCAL_IP" == x ];then
	exit 1
fi
registry_image_name=demoregistry.dataman-inc.com/library/centos7-docker-registry:v2.5.0.2016090301
if [ -f $CONFIG_DIR/config.yml ];then
	rm -rf $CONFIG_DIR/config.yml
fi
cp $CONFIG_DIR/config.yml.templ $CONFIG_DIR/config.yml && \
sed -i 's/--registry_ip--/'$LOCAL_IP'/g' $CONFIG_DIR/config.yml && \
docker images|grep $registry_image_name || docker load -i ../offline-images/registry.tar.gz 

mkdir -p ../offline-registry_data
