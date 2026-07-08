#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/wget.spec --nodeps
pushd ${RPMBUILD}/wget-1.24.5-build/wget-1.24.5/
unset PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/tools/lib64/pkgconfig
./configure ${COMMON_HOST_PREFIX} \
	    --sysconfdir=/tools/etc \
	    --with-ssl=openssl
make ${JOBS}
make install
popd
