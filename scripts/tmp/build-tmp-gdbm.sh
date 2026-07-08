#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/gdbm.spec --nodeps
pushd $RPMBUILD/gdbm-1.23-build/gdbm-1.23
pushd build-aux 
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
popd
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --build=${CROSS_HOST} --enable-libgdbm-compat
make ${JOBS}
make install
popd
