#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/binutils.spec --nodeps 
pushd $RPMBUILD/binutils-2.41-build/binutils-2.41
mkdir -v build
pushd build
../configure  ${COMMON_HOST_PREFIX_LIB} \
	      --build=${CROSS_HOST} --target=${CROSS_TARGET} \
	      --with-lib-path=/tools/lib64:/tools/lib \
	      --disable-nls --enable-shared \
	      --enable-64-bit-bfd
make configure-host
make $JOBS
make install
make -C ld clean
make -C ld LIB_PATH=/lib64:/lib
cp -v ld/.libs/ld-new /tools/bin/
cp -v libiberty/libiberty.a /tools/lib64/
cp -v ../include/libiberty.h /tools/include/
popd
popd
