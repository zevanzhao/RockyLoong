#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/check.spec --nodeps
pushd ${RPMBUILD}/check-0.15.2-build/check-0.15.2/
./configure ${COMMON_HOST_PREFIX_LIB} --disable-build-docs
make ${JOBS}
make install
popd
