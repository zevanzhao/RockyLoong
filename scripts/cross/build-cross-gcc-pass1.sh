#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/gcc.spec --nodeps
pushd $RPMBUILD/gcc-14.3.1-build/gcc-14.3.1-20250617/
for file in $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
do
    sed -i.orig -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' -e 's@/usr@/tools@' $file
done

sed -i.orig2 -e '/#define STANDARD_STARTFILE_PREFIX_1/s@STANDARD_STARTFILE_PREFIX_1 "/"@STANDARD_STARTFILE_PREFIX_1 "/tools/"@g' \
    -e '/define STANDARD_STARTFILE_PREFIX_2/s@"\(.*\)"@""@g' \
    gcc/gcc.cc gcc/config/loongarch/linux.h

sed -i.orig3 '/#define STANDARD_STARTFILE_PREFIX_1/s@"/lib@"/tools/lib@g' gcc/gcc.cc

#ATTENTION: Do not forget to update this file!
sed -i.orig 's@"\/lib" ABI_GRLEN_SPEC "\/ld-linux-loongarch-" ABI_SPEC "\.so\.1"@"\/tools/lib" ABI_GRLEN_SPEC "\/ld-linux-loongarch-" ABI_SPEC "\.so\.1"@g' gcc/config/loongarch/gnu-user.h

mkdir -p build
pushd build
../configure --prefix=/cross-tools --build=${CROSS_HOST} --host=${CROSS_HOST} \
	     --target=${CROSS_TARGET} --disable-nls \
	     --with-local-prefix=/tools --with-native-system-header-dir=/tools/include \
	     --with-mpfr=/cross-tools --with-gmp=/cross-tools --with-mpc=/cross-tools \
	     --with-newlib --with-sysroot=${SYSDIR} --disable-shared --disable-libitm \
	     --disable-decimal-float --disable-libgomp --disable-libsanitizer \
	     --disable-libquadmath --disable-threads --disable-target-zlib \
	     --with-system-zlib --enable-checking=release --with-linker-hash-style=both \
	     --enable-default-pie \
	     --enable-languages=c
make all-gcc $JOBS
make install-gcc $JOBS
make all-target-libgcc $JOBS
make install-target-libgcc $JOBS
popd
popd
