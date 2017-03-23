#!/bin/bash
# 功能: 从线上pull镜像导入线下安装registry
# Author: jyliu
set -e

BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR

images=`./print_json_value.py`
online_registry="demoregistry.dataman-inc.com"
offline_registry="offlineregistry.dataman-inc.com:5000"

mkdir -p ../offline-registry_data
mkdir -p ../offline-images

load_offlineregistry(){
	docker pull $offline_registry/$img &>/dev/null || go="ok"
	if [ x"$go" == x"ok" ];then
		docker pull $online_registry/$img &>/dev/null || go="fail"
		if [ x"$go" == x"fail" ];then
			echo "pull $online_registry/$img fail" && exit 1
		fi

		docker tag $online_registry/$img $offline_registry/$img
		if [ x"$go" == x"fail" ];then
			echo "tag $online_registry/$img fail" && exit 1
		fi

		docker push $offline_registry/$img &>/dev/null
		if [ x"$go" == x"fail" ];then
			echo "push $online_registry/$img fail" && exit 1
		fi
	fi
}

save_registry_image(){
	ls ../offline-images/registry.tar.gz ||	docker save $online_registry/library/centos7-docker-registry:v2.5.0.2016090301|gzip > ../offline-images/registry.tar.gz || echo "save registry images to fail."
}

main(){
	echo "##### load_offlineregistry start #####"
	save_registry_image
	for img in $images
	do
		load_offlineregistry
	done
	echo "##### load_offlineregistry end #####"
}
main
