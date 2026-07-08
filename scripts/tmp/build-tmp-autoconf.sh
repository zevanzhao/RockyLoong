#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/autoconf.spec --nodeps
pushd ${RPMBUILD}/autoconf-2.71-build/autoconf-2.71
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
