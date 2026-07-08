#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/tcl.spec --nodeps
pushd ${RPMBUILD}/tcl-8.6.13-build/tcl8.6.13
pushd unix
./configure ${COMMON_HOST_PREFIX_LIB} --mandir=/tools/share/man
make ${JOBS}
make install
make install-private-headers
ln -sfv tclsh8.6 /tools/bin/tclsh
ln -sfv libtcl8.6.so /tools/lib64/libtcl.so
popd
popd
