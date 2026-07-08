#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/tcsh.spec --nodeps
pushd ${RPMBUILD}/tcsh-6.24.10-build/tcsh-6.24.10
./configure ${COMMON_HOST_PREFIX} 
make ${JOBS}
make install
popd
