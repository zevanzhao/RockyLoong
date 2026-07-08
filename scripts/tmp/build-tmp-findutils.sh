#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/findutils.spec --nodeps
pushd ${RPMBUILD}/findutils-4.10.0-build/findutils-4.10.0
./configure ${COMMON_HOST_PREFIX} 
make ${JOBS}
make install
popd
