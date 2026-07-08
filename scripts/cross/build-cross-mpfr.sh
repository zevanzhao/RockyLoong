#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/mpfr.spec --nodeps
pushd $RPMBUILD/mpfr-4.2.1-build/mpfr-4.2.1
./configure --prefix=/cross-tools --disable-static --with-gmp=/cross-tools
make $JOBS
make install
popd
