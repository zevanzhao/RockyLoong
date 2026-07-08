#!/bin/bash
rpmbuild -bp rpmbuild/SPECS/gcc.spec --nodeps
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
rm -rf ./*
../configure ${COMMON_HOST_PREFIX_LIB} \
	     --target=${CROSS_TARGET} --build=${CROSS_HOST} --with-local-prefix=/tools \
	     --with-native-system-header-dir=/tools/include --disable-libstdcxx-pch \
	     --with-system-zlib --enable-checking=release --enable-__cxa_atexit \
	     --enable-linker-build-id --with-linker-hash-style=both \
	     --enable-languages=c,c++,fortran,objc,obj-c++,lto
make $JOBS
make install
ln -sv ../bin/cpp /tools/lib
ln -sv gcc /tools/bin/cc
popd
popd
