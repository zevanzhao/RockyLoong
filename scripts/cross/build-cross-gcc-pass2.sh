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

mkdir -p build_full
pushd build_full
AR=ar LDFLAGS="-Wl,-rpath,${SYSDIR}/cross-tools/lib" \
../configure --prefix=/cross-tools --build=${CROSS_HOST} --host=${CROSS_HOST} \
	     --target=${CROSS_TARGET} --with-sysroot=${SYSDIR} \
	     --with-local-prefix=/tools --with-native-system-header-dir=/tools/include \
	     --with-mpfr=/cross-tools --with-gmp=/cross-tools \
	     --with-mpc=/cross-tools --with-isl=/cross-tools/ \
	     --enable-__cxa_atexit --enable-threads=posix --with-system-zlib \
	     --enable-libstdcxx-time --enable-checking=release \
	     --with-linker-hash-style=both \
	     --enable-default-pie \
	     --enable-languages=c,c++,fortran,objc,obj-c++,lto

echo "make"
make all-gcc $JOBS
make all-target-libgcc $JOBS
make $JOBS
echo "make install"
make install
popd
popd
