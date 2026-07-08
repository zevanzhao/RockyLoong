#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/libmpc.spec --nodeps
pushd $RPMBUILD/libmpc-1.3.1-build/mpc-1.3.1/
./configure --build=${CROSS_HOST} ${COMMON_HOST_PREFIX_LIB}
make $JOBS
make install
popd
