#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/dhcpcd.spec --nodeps
pushd ${RPMBUILD}/dhcpcd-10.0.6-build/dhcpcd-10.0.6/
./configure ${COMMON_HOST_PREFIX_LIB}  --localstatedir=/tools/var 
make ${JOBS}
make install
popd
