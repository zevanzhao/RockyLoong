#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/libarchive.spec --nodeps 
pushd ${RPMBUILD}/libarchive-3.7.7-build/libarchive-3.7.7/
sed -i "s/1.16.5/1.18.1/g" aclocal.m4
sed -i "s/1.16/1.18/g" aclocal.m4
sed -i "s/1.16/1.18/g" configure
#autoreconf -fv
./configure ${COMMON_HOST_PREFIX_LIB}
make $JOBS
make install
popd
