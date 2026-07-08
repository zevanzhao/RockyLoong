#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/gcc.spec --nodeps
pushd $RPMBUILD/gcc-14.3.1-build/gcc-14.3.1-20250617/isl-0.24
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
mkdir -p build
pushd build
../configure --build=${CROSS_HOST} ${COMMON_HOST_PREFIX_LIB}
make $JOBS
make install
popd
popd
