#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/dosfstools.spec --nodeps
pushd ${RPMBUILD}/dosfstools-4.2-build/dosfstools-4.2/
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
./configure ${COMMON_HOST_PREFIX} --enable-compat-symlinks
make ${JOBS}
make install
popd
