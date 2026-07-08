#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/file.spec --nodeps
pushd ${RPMBUILD}/file-5.45-build/file-5.45
./configure ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
