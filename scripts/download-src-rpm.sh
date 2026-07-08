#!/bin/bash
pushd ${SRPMS}
mkdir -p devel
rsync -r --progress --delete --update rsync://mirror.nju.edu.cn/rocky/10.1/devel/source/tree/ devel
find ./devel -type f -name *.rpm |xargs mv -v -t ./
popd
