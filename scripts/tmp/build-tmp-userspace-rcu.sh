#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/userspace-rcu --nodeps
pushd ${RPMBUILD}/userspace-rcu-0.14.0-build/userspace-rcu-0.14.0/
pushd config
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
popd
patch -Np1 -i ${DOWNLOADDIR}/rcu-add-loongarch.patch
autoreconf -fv
./configure ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
