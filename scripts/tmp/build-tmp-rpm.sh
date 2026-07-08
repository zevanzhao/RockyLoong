#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/rpm.spec --nodeps
pushd ${RPMBUILD}/rpm-4.19.1.1-build/rpm-4.19.1.1
#patch -R -pN < ~/rpmbuild/SOURCES/rpm-4.19.x-pqc-algo.patch 
patch -p0 <${DOWNLOADDIR}/fix-rpmvs.patch
mkdir -pv _build
pushd _build
unset PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/tools/lib64/pkgconfig
cmake -DCMAKE_TOOLCHAIN_FILE=${SYSDIR}/cross-tools/loongarch64-toolchain.cmake \
      -DCMAKE_INSTALL_PREFIX=/tools/ \
      -DCMAKE_INSTALL_LIBDIR=/tools/lib64 \
      -DRPM_VENDOR=redhat \
      -DWITH_DBUS=OFF \
      -DENABLE_TESTSUITE=OFF \
      -DENABLE_PLUGINS=OFF \
      -DWITH_SEQUOIA=OFF \
      -DWITH_FSVERITY=OFF \
      -DWITH_INTERNAL_OPENPGP=ON} \
      -DENABLE_PYTHON=OFF \
      -DWITH_OPENSSL=ON \
      ..

make ${JOBS}
make install
popd
popd
