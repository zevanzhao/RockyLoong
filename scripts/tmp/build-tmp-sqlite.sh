#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/sqlite.spec --nodeps
pushd ${RPMBUILD}/sqlite-3.46.1-build/sqlite-src-3460100
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
./configure ${COMMON_HOST_PREFIX_LIB} --build=${CROSS_HOST} --enable-fts5 --disable-tcl
make ${JOBS}
make install
popd
