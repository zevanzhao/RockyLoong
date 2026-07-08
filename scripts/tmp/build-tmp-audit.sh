#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/audit.spec --nodeps
pushd ${RPMBUILD}/audit-4.0.3-build/audit-userspace-4.0.3
autoreconf -fv --install
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --with-python=no \
            --with-python3=no \
            --without-golang \
	    --enable-zos-remote=no
make ${JOBS}
make install
popd
