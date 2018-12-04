#!/bin/bash

set -ue

yum install -y vim zip perl

BASE_DIR=/tmp/layer
SRC_DIR=${BASE_DIR}/src
DST_DIR=${BASE_DIR}/dst
TARGET=${BASE_DIR}/lambda-vim-layer.zip
VIMRC_PATH=${BASE_DIR}/dst/vim/vimrc

# Create Destination folder
mkdir -p ${DST_DIR}

# Copy Vim Binary
mkdir -p ${DST_DIR}/bin
cp /usr/bin/vim ${DST_DIR}/bin/

# Copy Vim dependent library
mkdir -p ${DST_DIR}/lib
for lib in libgpm.so.2 libruby.so.2.0; do
  cp "/usr/lib64/${lib}" ${DST_DIR}/lib/
done

# Copy Vim bundle folder
mkdir -p ${DST_DIR}/vim/
cp -r ${SRC_DIR}/vim/bundle ${DST_DIR}/vim

# Put Vimrc header
cat ${SRC_DIR}/vim/vimrc_header > ${VIMRC_PATH}

# Copy Vim runtimes
mkdir -p ${DST_DIR}/vim/runtime
VIMRUNTIMEPATH=`vim -e -T dumb --cmd 'exe "set t_cm=\<C-M>"|echo &runtimepath|quit' | tr -d '\015' `
export IFS=","
for path in ${VIMRUNTIMEPATH}; do
  if [ -d "$path" ]; then
    not_conflict=true
    m=512
    prefix=""
    for p in ${VIMRUNTIMEPATH}; do
      if [[ "$p" != "$path" && "$path" == $p* ]]; then
        not_conflict=false
        if [ ${#p} -lt $m ]; then
          prefix=$p
          m=${#p}
        fi
      fi
    done
    if $not_conflict; then
      cp -rfp $path ${DST_DIR}/vim/runtime
      runtime_path="/runtime/$(basename $path)"
      echo "execute 'set rtp+=' . expand('<sfile>:p:h') . '${runtime_path}'" >> ${VIMRC_PATH}
    else
      translate_path=$(echo $path | sed "s,^${prefix},,g")
      runtime_path="/runtime/$(basename $prefix)${translate_path}"
      echo "execute 'set rtp+=' . expand('<sfile>:p:h') . '${runtime_path}'" >> ${VIMRC_PATH}
    fi
  fi
done

# Put Vimrc footer
cat ${SRC_DIR}/vim/vimrc_footer >> ${VIMRC_PATH}

# Copy bootstrap
cp ${SRC_DIR}/bootstrap ${DST_DIR}/bootstrap
chmod 755 ${DST_DIR}/bootstrap

# Create final zip product
cd ${DST_DIR}
zip -r ${TARGET} .
