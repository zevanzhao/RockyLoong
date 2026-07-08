#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/libmicrohttpd.spec --nodeps 
pushd ${RPMBUILD}/libmicrohttpd-1.0.0-build/libmicrohttpd-1.0.0/
./configure ${COMMON_HOST_PREFIX_LIB}
make $JOBS
make install
popd
