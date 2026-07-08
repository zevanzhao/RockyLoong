#!/bin/bash
pushd $RPMBUILD
rm -rfv grub-2.14
tar xvfJ ${DOWNLOADDIR}/grub-2.14.tar.xz
pushd grub-2.14
mkdir -pv build
pushd build
TARGET_CC=${CROSS_TARGET}-gcc \
	 ../configure --build=${CROSS_HOST} --host=${CROSS_HOST} --prefix=/cross-tools\
	 --program-transform-name=s,grub,${CROSS_TARGET}-grub, \
	 --with-platform=efi --with-utils=host --disable-werror
make $JOBS
make install
make check
popd
popd
popd
