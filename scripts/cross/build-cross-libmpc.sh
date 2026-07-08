#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/libmpc.spec --nodeps
pushd $RPMBUILD/libmpc-1.3.1-build/mpc-1.3.1/
./configure --prefix=/cross-tools --disable-static --with-gmp=/cross-tools
make $JOBS
make install
popd
