#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/make.spec --nodeps
pushd ${RPMBUILD}/make-4.4.1-build/make-4.4.1/
autoreconf -iv
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
