#!/bin/bash
#build kernel header for linux 6.17.11
pushd ${BUILDDIR}/linux-source-6.17
make mrproper
make ARCH=loongarch headers
find usr/include -name “.*” -delete
mkdir -pv /tools/include
echo "Copy usr/include/* to /tools/include"
cp -r usr/include/* /tools/include
#Remove the Makefile
rm -v /tools/include/Makefile
popd
