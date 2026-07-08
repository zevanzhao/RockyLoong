rpmbuild -bp ~/rpmbuild/SPECS/zlib.spec --nodeps
pushd $RPMBUILD/zlib-1.2.11-build/zlib-1.2.11/
./configure ${COMMON_PREFIX_LIB}
make $JOBS
make install
popd
