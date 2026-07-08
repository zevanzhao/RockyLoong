#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/kmod.spec --nodeps
pushd ${RPMBUILD}/kmod-31-build/kmod-31/
unset PKG_CONFIG_PATH
export PKG_CONFIG_PATH+=/tools/lib64/pkgconfig:
export PKG_CONFIG_PATH+=/tools/share/pkgconfig
autoreconf -fv
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --with-xz --with-zstd --with-zlib \
	    
make ${JOBS}
make install

for target in depmod insmod lsmod modprobe rmmod
do
    ln -sfv ../bin/kmod /tools/bin/${target}
done
ln -sfv kmod /tools/bin/lsmod
popd
