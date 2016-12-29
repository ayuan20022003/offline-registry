#!/bin/bash
set -xe

# 功能: 从线上 pull borg 镜像导入线下安装registry

BASE_DIR=$(cd `dirname $0` && pwd)
	cd $BASE_DIR

	img=$1
	offline_registry="offlineregistry.dataman-inc.com:5000"

# mkdir -p ../offline-registry_data
# mkdir -p ../offline-images

	load_offlineregistry(){
			docker tag $img $offline_registry/shurenyun/centos7-$img && \
					docker push $offline_registry/shurenyun/centos7-$img &>/dev/null && echo "load $img successful." || (echo "load $img  error !!!" && exit 1)
	}

load_offlineregistry

sed -i "s/centos7-borgsphere:.*/centos7-${img}/g"  /data/offlinesry/ansible/roles/copy-run-script/templates/run_3.0.sh.j2
