#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/curl.spec --nodeps 
pushd ${RPMBUILD}/curl-8.12.1-build/curl-8.12.1
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --with-openssl \
	    --enable-threaded-resolver --with-ca-path=/etc/ssl/certs
make $JOBS
make install
popd
