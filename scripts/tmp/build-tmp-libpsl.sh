#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/libpsl.spec --nodeps 
pushd ${RPMBUILD}/libpsl-0.21.5-build/libpsl-0.21.5
./configure  ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
