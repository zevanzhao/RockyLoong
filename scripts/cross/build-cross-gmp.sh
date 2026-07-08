#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/gmp.spec --nodeps
pushd $RPMBUILD/gmp-6.2.1-build/gmp-6.2.1
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
./configure --prefix=/cross-tools/ --enable-cxx --disable-static
make $JOBS
make check
make install
popd
