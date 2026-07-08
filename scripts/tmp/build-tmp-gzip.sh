#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/gzip.spec --nodeps
pushd ${RPMBUILD}/gzip-1.13-build/gzip-1.13
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
