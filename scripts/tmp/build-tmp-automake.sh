#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/automake.spec --nodeps
pushd ${RPMBUILD}/automake-1.16.5-build/automake-1.16.5/
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
