#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/gawk.spec --nodeps
pushd ${RPMBUILD}/gawk-5.3.0-build/gawk-5.3.0
sed -i "/SUBDIRS/s@test@@g" Makefile.{in,am}
sed -i "s/1.16.5/1.18.1/g" aclocal.m4
sed -i "s/1.16/1.18/g" aclocal.m4
sed -i "s/1.16/1.18/g" configure
./configure ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
