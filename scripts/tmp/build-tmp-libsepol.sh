#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/libsepol.spec --nodeps 
pushd ${RPMBUILD}/libsepol-3.9-build/libsepol-3.9/
make PREFIX=/tools SHLIBDIR=/tools/lib64 LIBDIR=/tools/lib64 ${JOBS}
make PREFIX=/tools SHLIBDIR=/tools/lib64 LIBDIR=/tools/lib64 install
popd
