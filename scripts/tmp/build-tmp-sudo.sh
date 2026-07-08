#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/sudo.spec --nodeps
pushd ${RPMBUILD}/sudo-1.9.15-build/sudo-1.9.15p5
./configure ${COMMON_HOST_PREFIX}\
	    --sysconfdir=/tools/etc \
	    --with-rundir=/tools/var/run \
	    --with-vardir=/tools/var \
	    --enable-tmpfiles.d=/tools/lib/tmpfiles.d \
	    --with-secure-path \
	    --with-all-insults \
	    --with-editor=/tools/bin/vi \
	    --with-env-editor \
            --with-passprompt="[sudo] password for %p: "
sed -i "/^install_uid/s@= 0@= $(id -u)@g" Makefile
sed -i "/^install_gid/s@= 0@= $(id -g)@g" Makefile
sed -i "/^sudoers_uid/s@= 0@= $(id -u)@g" Makefile
sed -i "/^sudoers_gid/s@= 0@= $(id -g)@g" Makefile
make ${JOBS}
make install
popd
