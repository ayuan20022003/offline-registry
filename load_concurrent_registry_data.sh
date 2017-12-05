#!/bin/bash
set -e

# 功能: 从线上pull镜像导入线下安装registry
# Author: jyliu

BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR

images=`./print_json_value.py`
online_registry="registry.docker-cn.com"
offline_registry="offlineregistry.dataman-inc.com:5000"

mkdir -p ../offline-registry_data
mkdir -p ../offline-images
num=0
load_offlineregistry(){
	docker pull $online_registry/$img &>/dev/null && echo "pull $img successful." && \
	docker tag $online_registry/$img $offline_registry/$img && \
	docker push $offline_registry/$img &>/dev/null && echo "load $img successful." || (echo "load $img  error !!!" && num=1 && exit 1)
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

if [ $num -eq 0 ];then
	echo "load all images done."
fi
