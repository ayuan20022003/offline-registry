BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR

./load_concurrent_registry_data.sh ../docker.io.imagelist.txt docker.io &
./load_concurrent_registry_data.sh ../dmos.imagelist.txt demoregistry.dataman-inc.com &
wait
