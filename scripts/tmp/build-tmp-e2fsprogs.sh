#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/e2fsprogs.spec --nodeps
pushd ${RPMBUILD}/e2fsprogs-1.47.1-build/e2fsprogs-1.47.1/
mkdir -v build
pushd build
../configure ${COMMON_HOST_PREFIX_LIB} \
	     --sysconfdir=/tools/etc \
	     --with-crond-dir=no \
	     --sbindir=/tools/sbin \
	     --enable-elf-shlibs \
	     --disable-libblkid \
	     --disable-libuuid \
	     --disable-uuidd \
	     --disable-fsck \
	     --disable-debugfs \
	     LDFLAGS="-L/tools/lib64 -luuid -lblkid"
make ${JOBS}
make install
popd
popd
