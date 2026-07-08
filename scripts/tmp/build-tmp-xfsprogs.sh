#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/xfsprogs.spec --nodeps
pushd ${RPMBUILD}/xfsprogs-6.11.0-build/xfsprogs-6.11.0/
DEBUG=-DNDEBUG INSTALL_USER=root INSTALL_GROUP=root \ 
./configure ${COMMON_HOST_PREFIX} --enable-readline
make ${JOBS}
make DESTDIR=${SYSDIR} install
make DESTDIR=${SYSDIR} install-dev
popd
