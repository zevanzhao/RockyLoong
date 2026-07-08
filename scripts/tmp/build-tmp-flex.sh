#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/flex.spec --nodeps
pushd ${RPMBUILD}/flex-2.6.4-build/flex-2.6.4
pushd build-aux
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./

popd
autoreconf -fv
./configure ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
