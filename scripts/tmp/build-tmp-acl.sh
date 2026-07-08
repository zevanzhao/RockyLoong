#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/acl.spec --nodeps
pushd ${RPMBUILD}/acl-2.3.2-build/acl-2.3.2
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --disable-static
make ${JOBS}
make install
popd
