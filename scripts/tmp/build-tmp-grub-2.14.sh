#!/bin/bash
pushd $RPMBUILD
rm -rfv grub-2.14
tar xvfJ ${DOWNLOADDIR}/grub-2.14.tar.xz
pushd grub-2.14
mkdir -pv cross-build
pushd cross-build
mkdir -p grub-core
touch grub-core/extra_deps.lst
CC=$CC \
    ../configure ${COMMON_HOST_PREFIX} \
    --with-platform=efi --with-utils=host --disable-werror
make $JOBS
make install
make check
popd
popd
popd
