#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/bzip2.spec --nodeps
pushd ${RPMBUILD}/bzip2-1.0.8-build/bzip2-1.0.8
	sed -i.orig -e "/^all:/s/ test//" Makefile
	sed -i -e 's:ln -s -f $(PREFIX)/bin/:ln -s -f :' Makefile
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
	make CC="${CC}" -f Makefile-libbz2_so ${JOBS}
	make clean
	make CC="${CC}" AR="${AR}" RANLIB="${RANLIB}" ${JOBS}
	make PREFIX=${SYSDIR}/tools install
	cp -av libbz2.so* /tools/lib64
	ln -sfv libbz2.so.1.0.8 /tools/lib64/libbz2.so.1
	ln -sfv libbz2.so.1.0 /tools/lib64/libbz2.so
	cp -v bzip2-shared /tools/bin/bzip2
	ln -sfv bzip2 /tools/bin/bunzip2
	ln -sfv bzip2 /tools/bin/bzcat
popd
