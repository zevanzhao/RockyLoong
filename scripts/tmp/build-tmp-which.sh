#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/which.spec --nodeps
pushd ${RPMBUILD}/which-2.21-build/which-2.21/
./configure ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
