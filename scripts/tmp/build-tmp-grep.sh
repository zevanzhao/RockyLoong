#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/grep.spec --nodeps
pushd ${RPMBUILD}/grep-3.11-build/grep-3.11/
sed -i "s/1.16i/1.18.1/g" aclocal.m4
sed -i "s/1.16/1.18/g" aclocal.m4
sed -i "s/1.16/1.18/g" configure
./configure ${COMMON_HOST_PREFIX}
make ${JOBS}
make install
popd
