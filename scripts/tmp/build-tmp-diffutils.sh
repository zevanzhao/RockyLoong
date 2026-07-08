#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/diffutils.spec --nodeps
pushd ${RPMBUILD}/diffutils-3.10-build/diffutils-3.10//
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
