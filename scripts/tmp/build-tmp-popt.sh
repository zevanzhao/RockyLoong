#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/popt.spec --nodeps 
pushd ${RPMBUILD}/popt-1.19-build/popt-1.19/
pushd build-aux
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
popd
./configure ${COMMON_HOST_PREFIX_LIB}
make $JOBS
make install
popd
