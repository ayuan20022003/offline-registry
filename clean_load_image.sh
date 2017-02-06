#!/bin/bash
set -e
BASE_DIR=$(cd `dirname $0` && pwd)
cd $BASE_DIR

./stop.sh
rm -rf ../offline-registry_data
./run.sh
sleep 5
./load_registry_data.sh
