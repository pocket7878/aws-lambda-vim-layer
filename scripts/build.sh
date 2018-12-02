#!/bin/bash

set -ue

yum install -y vim zip

BASE_DIR="/tmp/layer"

cd ${BASE_DIR}

mkdir -p bin
cp /usr/bin/vim bin/

mkdir -p lib
for lib in libgpm.so.2 libruby.so.2.0; do
  cp "/usr/lib64/${lib}" lib/
done

chmod 755 'bootstrap'

zip -r "${BASE_DIR}/lambda-vim-layer.zip" .
