#!/bin/bash

# 功能: 从线上pull镜像导入线下安装registry
# Author: jyliu

images=`cat imagelist.txt`
online_registry="demoregistry.dataman-inc.com"
offline_registry="offlineregistry.dataman-inc.com:5000"

load_offlineregistry(){
	docker pull $online_registry/$img &>/dev/null && echo "pull $img successful." && \
	docker tag $online_registry/$img $offline_registry/$img && \
	docker push $offline_registry/$img &>/dev/null && echo "load $img successful." || echo "load $img  error !!!"
}

export_registryimages(){

}

for img in $images
do
	load_offlineregistry &
done
wait

