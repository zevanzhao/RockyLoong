#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/uuid.spec --nodeps
pushd ${RPMBUILD}/uuid-1.6.2-build/uuid-1.6.2
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
./configure ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
