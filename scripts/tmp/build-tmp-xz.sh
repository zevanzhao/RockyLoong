#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/xz.spec --nodeps
pushd ${RPMBUILD}/xz-5.6.2-build/xz-5.6.2
./configure ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
