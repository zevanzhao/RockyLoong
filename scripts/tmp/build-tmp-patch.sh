#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/patch.spec --nodeps
pushd ${RPMBUILD}/patch-2.7.6-build/patch-2.7.6/
pushd build-aux
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
popd
autoreconf -iv
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
