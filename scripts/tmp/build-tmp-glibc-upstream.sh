#!/bin/bash
pushd $RPMBUILD/glibc-2.39
mkdir -v build
pushd build
#deprecated, replaced by libc_cv_slibdir
#echo "slibdir=/tools/lib" >>configparms
BUILD_CC="gcc" CC="/cross-tools/bin/gcc " \
	CXX="/cross-tools/bin/gcc" \
        AR="/cross-tools/bin/ar" RANLIB="/cross-tools/bin/ranlib" \
        ../configure --prefix=/tools \
	--libdir=/tools/lib --libexecdir=/tools/lib/glibc \
	--enable-kernel=5.19 --with-binutils=/cross-tools/bin \
	--with-headers=/tools/include  --enable-obsolete-rpc \
	--enable-stack-protector=strong --enable-add-ons \
	--disable-werror --disable-nscd --enable-obsolete-rpc \
	libc_cv_slibdir=/tools/lib
make
make install
popd
popd
