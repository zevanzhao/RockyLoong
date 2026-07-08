#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/libxcrypt.spec --nodeps
pushd ${RPMBUILD}/libxcrypt-4.4.36-build/libxcrypt-4.4.36
./configure ${COMMON_HOST_PREFIX_LIB} --disable-werror
make ${JOBS}
make install
popd
