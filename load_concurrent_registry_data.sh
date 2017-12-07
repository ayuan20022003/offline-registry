#!/bin/bash
set -e

# 功能: 从线上pull镜像导入线下安装registry
# Author: jyliu

BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR


if [  -f "../offlinesry/config.cfg" ];then
	. ../offlinesry/config.cfg
elif [ -f "../config.cfg" ];then
        . ../config.cfg
else
	. ./config.cfg
fi

export IMAGELIST_FILE_PATH=$1
online_registry=$2


if [ -z "$IMAGELIST_FILE_PATH" ] || [ -z "$online_registry" ];then
	echo "Usage: $0 <IMAGELIST_FILE> <online_registry_domain> [single_image]"
	exit 1
fi

if [ "$online_registry" == "docker.io" ];then
	online_registry="registry.docker-cn.com"
fi
	
offline_registry="offlineregistry.dataman-inc.com:5000"

images=$3
if [ -z "$images" ];then
        images=`./print_json_value.py`
fi

mkdir -p ../offline-registry_data
mkdir -p ../offline-images

rm -f /tmp/loadimageerr.log
rm -f /tmp/loadimagestatus.log
load_offlineregistry(){
	docker pull $online_registry/$img &>/dev/null && echo "pull $img successful." && \
	docker tag $online_registry/$img $offline_registry/$img && \
	docker push $offline_registry/$img &>/dev/null && echo "load $img successful." || (echo "pull or load $img  error !!!" >> /tmp/loadimageerr.log && echo 1 > /tmp/loadimagestatus.log)
}


for img in $images
do
	load_offlineregistry &
done
wait


save_registry_image(){
	ls ../offline-images/registry.tar.gz ||	docker save $online_registry/library/centos7-docker-registry:v2.5.0.2016090301|gzip > ../offline-images/registry.tar.gz && echo "save registry images to successful."
}

save_registry_image

if [ -f "/tmp/loadimagestatus.log" ];then
	num=`cat /tmp/loadimagestatus.log`
else
	num=0
fi

if [ "$num" -eq 0 ];then
	echo "load all images done."
else
	cat /tmp/loadimageerr.log	
fi
