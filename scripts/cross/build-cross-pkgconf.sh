#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/pkgconf.spec --nodeps
pushd $RPMBUILD/pkgconf-2.1.0-build/pkgconf-2.1.0
unset PKGPATH
export PKGPATH+=/tools/lib/pkgconfig:
export PKGPATH+=/tools/share/pkgconfig
CC="gcc" ./configure --prefix=/cross-tools --with-pkg-conf-dir=${PKGPATH}
make $JOBS
make install
ln -sv pkgconf /cross-tools/bin/pkg-config
unset PKGPATH
popd
