#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/cpio.spec --nodeps
pushd ${RPMBUILD}/cpio-2.15-build/cpio-2.15/
./configure ${COMMON_HOST_PREFIX} --enable-mt
make ${JOBS}
make install
popd
