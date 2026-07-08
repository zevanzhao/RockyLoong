#!/bin/bash
rpmbuild -D "version_no_tilde 257" -bp ~/rpmbuild/SPECS/systemd.spec --nodeps
pushd ${RPMBUILD}/systemd-257-build/systemd-257/
unset  PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/tools/lib64/pkgconfig
sed -i "s@/usr/local/@/tools/@g" src/basic/path-util.h
sed -i -e 's/GROUP="render"/GROUP="video"/' \
    -e 's/GROUP="sgx", //' rules.d/50-udev-default.rules.in
mkdir -pv build
pushd build
CC="gcc" CXX="g++" \
  meson --prefix=/tools/ --libdir=/tools/lib64 --sysconfdir=/tools/etc --localstatedir=/tools/var \
  -Dblkid=true -Dbuildtype=release -Ddefault-dnssec=no -Dfirstboot=false \
  -Dinstall-tests=false -Dkmod-path=/tools/bin/kmod -Dldconfig=false  \
  -Dmount-path=/tools/bin/mount -Drootprefix=/tools/ -Drootlibdir=/tools/lib64/ \
  -Dsplit-usr=true -Dsulogin-path=/tools/sbin/sulogin -Dsysusers=false \
  -Dumount-path=/tools/bin/umount -Db_lto=false \
  -Dsysvinit-path=/tools/etc/init.d -Dsysvrcnd-path=/tools/etc/rc.d \
  -Dcreate-log-dirs=false -Dbinfmt=false -Dtimesyncd=false \
  -Drpmmacrosdir=no -Dhomed=false -Duserdb=false -Dman=false -Dmode=release -Dlogind=true \
  -Dpamconfdir=/tools/etc/pam.d \
  -Ddbuspolicydir=/tools/share/dbus-1/system.d -Ddbussessionservicedir=/tools/share/dbus-1/services \
  -Ddbussystemservicedir=/tools/share/dbus-1/system-services \
  -Dbashcompletiondir=/tools/share/bash-completion/completions \
  --cross-file ${SYSDIR}/cross-tools/meson-cross.txt ..
ninja
DESTDIR=${SYSDIR} ninja install
popd
