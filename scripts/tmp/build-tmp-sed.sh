#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/sed.spec --nodeps
pushd ${RPMBUILD}/sed-4.9-build/sed-4.9/
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
