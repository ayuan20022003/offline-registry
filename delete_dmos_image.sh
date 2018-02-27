#!/bin/bash
# 清理offline registry 中 dmos 镜像
BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR

../delete-docker-registry-image/delete_offline_registry_image.sh jborg/dmos-oc-ui
../delete-docker-registry-image/delete_offline_registry_image.sh jborg-dev/dmos-oc-ui
../delete-docker-registry-image/delete_offline_registry_image.sh jborg/dmos-oc
../delete-docker-registry-image/delete_offline_registry_image.sh jborg-dev/dmos-oc
../delete-docker-registry-image/delete_offline_registry_image.sh polypite/origin-dm-web
../delete-docker-registry-image/delete_offline_registry_image.sh polypite-dev/origin-dm-web
