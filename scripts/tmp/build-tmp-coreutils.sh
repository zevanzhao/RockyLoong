#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/coreutils.spec --nodeps
pushd ${RPMBUILD}/coreutils-9.5-build/coreutils-9.5
./configure ${COMMON_HOST_PREFIX} \
	    --enable-install-program=hostname
make ${JOBS}
make install
popd
