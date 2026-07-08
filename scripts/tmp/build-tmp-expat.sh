#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/expat.spec --nodeps 
pushd ${RPMBUILD}/expat-2.7.1-build/expat-2.7.1/
sed -i "s/xmlwf doc/xmlwf #doc/g" Makefile.in
./configure ${COMMON_HOST_PREFIX_LIB} --without-docbook
make $JOBS
make install
popd
