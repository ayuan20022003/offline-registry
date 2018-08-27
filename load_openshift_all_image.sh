BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR

# 打包标签，dev 或 stable, dev 从 dev.imagelist.txt取镜像列表
PACKAGEING_TAG=${1:-stable}

./load_concurrent_registry_data.sh ../offline-dmos/images_manage/docker.io.imagelist.txt docker.io &
./load_concurrent_registry_data.sh ../offline-dmos/images_manage/quay.io.imagelist.txt quay.io &
./load_concurrent_registry_data.sh ../offline-dmos/images_manage/devharbor.imagelist.txt devharbor.dataman-inc.com:1443 &

if [ "x$PACKAGEING_TAG" == "xdev" ];then
	./load_concurrent_registry_data.sh ../offline-dmos/images_manage/dmos.dev.imagelist.txt devharbor.dataman-inc.com:1443 &
else
	./load_concurrent_registry_data.sh ../offline-dmos/images_manage/dmos.imagelist.txt devharbor.dataman-inc.com:1443 &
fi

wait
