#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/texinfo.spec --nodeps
pushd ${RPMBUILD}/texinfo-7.1-build/texinfo-7.1
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
