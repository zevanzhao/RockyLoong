#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/nettle.spec --nodeps
pushd ${RPMBUILD}/nettle-3.10.1-build/nettle-3.10.1/
autoreconf -ifv
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --disable-sm3 --disable-sm4
make ${JOBS}
make install
popd
