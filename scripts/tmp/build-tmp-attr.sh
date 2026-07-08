#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/attr.spec --nodeps
pushd ${RPMBUILD}/attr-2.5.2-build/attr-2.5.2
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --disable-static \
	    --sysconfdir=/tools/etc
make ${JOBS}
make install
popd
