#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/shadow-utils.spec --nodeps
pushd ${RPMBUILD}/shadow-utils-4.15.0-build/shadow-4.15.0
sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD YESCRYPT:' -i etc/login.defs
./configure ${COMMON_HOST_PREFIX} \
	    --with-group-name-max-length=32 \
	    --with-bcrypt --with-yescrypt  --with-libbsd=no
make ${JOBS}
make install
popd
