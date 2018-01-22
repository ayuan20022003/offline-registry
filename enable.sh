#!/bin/bash
set -ex
base_dir=$(cd `dirname $0` && pwd)
cd $base_dir

cp offline-registry.service /usr/lib/systemd/system/
systemctl enable offline-registry
systemctl start offline-registry
