#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/ncurses.spec --nodeps
pushd ${RPMBUILD}/ncurses-6.4-build/ncurses-6.4-20240127
./configure ${COMMON_HOST_PREFIX_LIB} \
	    --with-shared --without-debug --without-ada \
	    --enable-pc-files  --with-pkg-config-libdir=/tools/lib64/pkgconfig \
	    --enable-widec --with-termlib=tinfo --disable-stripping
make ${JOBS}
make install
for lib in ncurses form panel menu
do
    rm -vf /tools/lib64/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /tools/lib64/lib${lib}.so
    ln -sfv ${lib}w.pc        /tools/lib64/pkgconfig/${lib}.pc
done
popd
