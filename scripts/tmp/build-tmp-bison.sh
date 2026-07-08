#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/bison.spec --nodeps
pushd ${RPMBUILD}/bison-3.8.2-build/bison-3.8.2
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
