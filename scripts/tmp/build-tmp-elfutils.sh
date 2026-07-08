#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/elfutils.spec --nodeps 
pushd ${RPMBUILD}/elfutils-0.193-build/elfutils-0.193/
./configure ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
