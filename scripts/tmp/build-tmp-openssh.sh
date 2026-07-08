#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/openssh.spec --nodeps
pushd ${RPMBUILD}/openssh-9.9p1-build/openssh-9.9p1/
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --with-privsep-path=/tools/var/lib/sshd \
	    --with-pid-dir=/tools/run \
	    --with-default-path=/tools/bin/ \
	    --with-ssl-dir=/tools \
	    --disable-strip \
	    --with-pam \
	    --without-openssl-header-check 
make ${JOBS}
make DESTDIR=${SYSDIR} install-nokeys host-key
popd
