#!/bin/bash
#build kernel header for linux 6.17.11
pushd ${BUILDDIR}/linux-source-6.17
make mrproper
make ARCH=loongarch headers
find usr/include -name “.*” -delete
rm usr/include/Makefile
mkdir -pv /tools/include
cp -rv usr/include/* /tools/include
popd
