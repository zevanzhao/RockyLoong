#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/tar.spec --nodeps
pushd ${RPMBUILD}/tar-1.35-build/tar-1.35/
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
