#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/libselinux.spec --nodeps 
pushd ${RPMBUILD}/libselinux-3.9-build/libselinux-3.9
PKG_CONFIG_PATH=/tools/lib64/pkgconfig USE_PCRE2=y make PREFIX=/tools SHLIBDIR=/tools/lib64 LIBDIR=/tools/lib64 ${JOBS}
make PREFIX=/tools SHLIBDIR=/tools/lib64 LIBDIR=/tools/lib64 install
popd
