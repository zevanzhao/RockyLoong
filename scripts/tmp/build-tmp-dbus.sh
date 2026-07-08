#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/dbus.spec --nodeps
pushd ${RPMBUILD}/dbus-1.14.10-build/dbus-1.14.10
unset PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/tools/lib64/pkgconfig/
autoreconf -fv
sed -i "/SUBDIRS/s@doc@@g" Makefile.{in,am}
./configure ${COMMON_HOST_PREFIX} --with-console-auth-dir=/tools/run/console
make ${JOBS}
make install
popd
