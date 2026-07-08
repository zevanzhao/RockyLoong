#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/binutils.spec --nodeps 
pushd $RPMBUILD/binutils-2.41-build/binutils-2.41
mkdir build
pushd build
CC=gcc AR=ar AS=as \
       ../configure --prefix=/cross-tools \
       --build=${CROSS_HOST} --host=${CROSS_HOST} \
       --target=${CROSS_TARGET} --with-sysroot=${SYSDIR} \
       --with-lib-path=/tools/lib64:/tools/lib \
       --disable-nls --disable-static --disable-werror \
       --enable-64-bit-bfd
make configure-host
make $JOBS
make install $JOBS
cp -v ../include/libiberty.h /tools/include/
popd
popd
