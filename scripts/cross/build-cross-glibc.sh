#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/glibc.spec --nodeps
pushd $RPMBUILD/glibc-2.39-build/glibc-2.39
mkdir -v build
pushd build
#deprecated, replaced by libc_cv_slibdir
#echo "slibdir=/tools/lib64" >>configparms
BUILD_CC="gcc" CC="${CROSS_TARGET}-gcc" \
	CXX="${CROSS_TARGET}-gcc" \
        AR="${CROSS_TARGET}-ar" RANLIB="${CROSS_TARGET}-ranlib" \
        ../configure --prefix=/tools --host=${CROSS_TARGET} --build=${CROSS_HOST} \
	--libdir=/tools/lib64 --libexecdir=/tools/lib64/glibc --enable-add-ons \
	--with-tls --enable-kernel=5.19 --with-binutils=/cross-tools/bin \
	--with-headers=/tools/include  --enable-obsolete-rpc \
	--enable-stack-protector=strong \
	--disable-werror --disable-nscd \
	libc_cv_slibdir=/tools/lib64
make $JOBS
make install
popd
popd
