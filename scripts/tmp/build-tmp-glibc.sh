#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/glibc.spec --nodeps
pushd $RPMBUILD/glibc-2.39-build/glibc-2.39
mkdir -v build
pushd build
#deprecated, replaced by libc_cv_slibdir
#echo "slibdir=/tools/lib" >>configparms
BUILD_CC="gcc" CC="${CROSS_TARGET}-gcc " \
	CXX="${CROSS_TARGET}-gcc" \
        AR="${CROSS_TARGET}-ar" RANLIB="${CROSS_TARGET}-ranlib" \
        ../configure --prefix=/tools --host=${CROSS_TARGET} --build=${CROSS_HOST} \
	--libdir=/tools/lib --libexecdir=/tools/lib/glibc \
	--enable-kernel=5.19 --with-binutils=/cross-tools/bin \
	--with-headers=/tools/include  --enable-obsolete-rpc \
	--enable-stack-protector=strong --enable-add-ons \
	--disable-werror --disable-nscd --enable-obsolete-rpc \
	libc_cv_slibdir=/tools/lib
make $JOBS
make install
popd
popd
