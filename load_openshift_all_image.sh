BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR

./load_concurrent_registry_data.sh ../offline-dmos/images_manage/docker.io.imagelist.txt docker.io &
./load_concurrent_registry_data.sh ../offline-dmos/images_manage/dmos.imagelist.txt devharbor.dataman-inc.com:1443 &
wait
