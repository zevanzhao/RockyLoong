#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/lua.spec --nodeps
pushd ${RPMBUILD}/lua-5.4.6-build/lua-5.4.6/
./configure ${COMMON_HOST_PREFIX_LIB} --with-compat-module --with-readline
make ${JOBS}
make install
popd
