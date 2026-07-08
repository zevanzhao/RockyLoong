rpmbuild -bp ~/rpmbuild/SPECS/nss.spec --nodeps
pushd ${RPMBUILD}/nss-3.112.0-build/nss-3.112/nss
#sed -i.bak "s@INCLUDES += -Impi -Iecl -Iverified -Iverified/internal@INCLUDES += -Impi -Iecl -Iverified -Iverified/internal -Ileancrypto @g" lib/freebl/Makefile
make CC="gcc" -C coreconf/nsinstall BUILD_OPT=1 USE_64=1 \
     CPU_ARCH="loongarch64" CROSS_COMPILE=1 NSS_ENABLE_WERROR=0 OS_TEST="loongarch64" ${JOBS}
make NATIVE_CC="gcc" CC="${CC}" CCC="${CXX}" \
     BUILD_OPT=1 USE_64=1 CPU_ARCH="loongarch64" CROSS_COMPILE=1 \
     USE_SYSTEM_ZLIB=1 NSS_USE_SYSTEM_SQLITE=1 NSS_ENABLE_WERROR=0 \
     NSS_DISABLE_DSA=1 NSS_ENABLE_ML_DSA=1 NSPR_INCLUDE_DIR=/tools/include/nspr OS_TEST="loongarch64" ${JOBS}

cat pkg/pkg-config/nss-config.in | sed -e "s,@prefix@,/usr,g" \
        -e "s,@MOD_MAJOR_VERSION@,$(cat lib/util/nssutil.h \
            | grep "#define.*NSSUTIL_VMAJOR" | awk '{print $3}'),g" \
        -e "s,@MOD_MINOR_VERSION@,$(cat lib/util/nssutil.h \
            | grep "#define.*NSSUTIL_VMINOR" | awk '{print $3}'),g" \
        -e "s,@MOD_PATCH_VERSION@,$(cat lib/util/nssutil.h \
            | grep "#define.*NSSUTIL_VPATCH" | awk '{print $3}'),g" \
        > /tools/bin/nss-config

cat pkg/pkg-config/nss.pc.in | sed -e "s,%prefix%,/usr,g" \
        -e 's,%exec_prefix%,${prefix},g' -e "s,%libdir%,/usr/lib64,g" \
        -e 's,%includedir%,${prefix}/include/nss,g' \
        -e "s,%NSS_VERSION%,$(cat lib/util/nssutil.h \
            | grep "#define.*NSSUTIL_VERSION" | awk '{print $3}'),g" \
        -e "s,%NSPR_VERSION%,$(cat /tools/include/nspr/prinit.h \
            | grep "#define.*PR_VERSION" | awk '{print $3}'),g" \
        > /tools/lib64/pkgconfig/nss.pc
    
pushd ${RPMBUILD}/nss-3.112.0-build/nss-3.112/dist
    install -v -m755 Linux*/lib/*.so /tools/lib64
    install -v -m644 Linux*/lib/libcrmf.a /tools/lib64
    install -v -m755 -d /tools/include/nss
    cp -v -RL {public,private}/nss/* /tools/include/nss
    chmod -v 644 /tools/include/nss/*
    install -v -m755 Linux*/bin/{certutil,pk12util} /tools/bin
popd
