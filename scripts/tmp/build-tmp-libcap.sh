#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/libcap.spec --nodeps 
pushd ${RPMBUILD}/libcap-2.69-build/libcap-2.69
make CC="${CC}" BUILD_CC="gcc" PAM_CAP=no RAISE_SETFCAP=no prefix=/tools/ ${JOBS}
make CC="${CC}" BUILD_CC="gcc" PAM_CAP=no RAISE_SETFCAP=no prefix=/tools/ install 
popd
