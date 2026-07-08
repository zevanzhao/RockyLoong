#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/util-linux.spec --nodeps
pushd ${RPMBUILD}/util-linux-2.40.2-build/util-linux-2.40.2/
unset PKG_CONFIG_PATH
export PKG_CONFIG_PATH+=/tools/lib64/pkgconfig:
export PKG_CONFIG_PATH+=/tools/share/pkgconfig
autoreconf -fv
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --disable-chfn-chsh --disable-login --disable-nologin \
            --disable-su --disable-setpriv --disable-runuser \
            --disable-pylibmount --disable-static --without-python \
            --without-systemd --disable-makeinstall-chown --disable-asciidoc \
	    --disable-schedutils
make ${JOBS}
make install
popd
