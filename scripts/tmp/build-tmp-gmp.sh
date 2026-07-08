#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/gmp.spec --nodeps
pushd $RPMBUILD/gmp-6.2.1-build/gmp-6.2.1
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --build=${CROSS_HOST} --enable-cxx 
make $JOBS
make install
popd
