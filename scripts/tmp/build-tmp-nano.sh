#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/nano.spec --nodeps
pushd ${RPMBUILD}/nano-8.1-build/nano-8.1
CFLAGS+=" -I/tools/include/ncursesw/" ./configure ${COMMON_HOST_PREFIX_LIB} --enable-utf8 LIBS="-lncurses -ltinfo"  LDFLAGS="-L/tools/lib64"
make ${JOBS}
make install
popd
