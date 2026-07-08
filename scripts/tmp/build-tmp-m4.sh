#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/m4.spec --nodeps
pushd ${RPMBUILD}/m4-1.4.19-build/m4-1.4.19/
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
