#!/bin/bash
src_file=$1
target_file=$2

if [ -f ${target_file} ]; then
  if [ "$(diff -q ${target_file} ${src_file})" ]; then
    diff -u ${target_file} ${src_file}
    cp ${src_file} ${target_file}
    echo "notice: File[${target_file}]ensure: content changed"
  fi
else
  cp ${src_file} ${target_file}
  echo "notice: File[${target_file}]ensure: defined content"
fi
