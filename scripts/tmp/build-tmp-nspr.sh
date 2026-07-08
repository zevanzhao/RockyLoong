rpmbuild -bp ~/rpmbuild/SPECS/nss.spec --nodeps
pushd ${RPMBUILD}/nss-3.112.0-build/nss-3.112/
pushd nspr
pushd build/autoconf
mv -v config.guess config.guess.bak
mv -v config.sub config.sub.bak
cp -v ${DOWNLOADDIR}/config.guess ./
cp -v ${DOWNLOADDIR}/config.sub ./
popd
./configure ${COMMON_HOST_PREFIX_LIB} \
            --host=${CROSS_TARGET} \
	    --with-mozilla \
            --with-pthreads \
	    --enable-64bit
make CC="gcc" -C config
make ${JOBS}
make install
popd
popd
