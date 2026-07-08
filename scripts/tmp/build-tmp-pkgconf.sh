#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/pkgconf.spec --nodeps
pushd $RPMBUILD/pkgconf-2.1.0-build/pkgconf-2.1.0
unset PKGPATH
export PKGPATH+=/tools/lib64/pkgconfig:
export PKGPATH+=/tools/share/pkgconfig
./configure ${COMMON_HOST_PREFIX_LIB} --with-pkg-conf-dir=${PKGPATH}
make $JOBS
make install
ln -sv pkgconf /tools/bin/pkg-config
unset PKGPATH
popd
