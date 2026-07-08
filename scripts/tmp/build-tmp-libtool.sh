#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/libtool.spec --nodeps
pushd ${RPMBUILD}/libtool-2.4.7-build/libtool-2.4.7
./configure ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
