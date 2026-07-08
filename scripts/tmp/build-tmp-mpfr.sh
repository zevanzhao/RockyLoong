#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/mpfr.spec --nodeps
pushd $RPMBUILD/mpfr-4.2.1-build/mpfr-4.2.1
./configure ${COMMON_HOST_PREFIX_LIB} --build=${CROSS_HOST}
make $JOBS
make install
popd
