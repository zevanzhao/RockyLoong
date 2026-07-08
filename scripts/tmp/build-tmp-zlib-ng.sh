rpmbuild -bp ~/rpmbuild/SPECS/zlib-ng.spec --nodeps
pushd $RPMBUILD/zlib-ng-2.2.3-build/zlib-ng-2.2.3/
./configure ${COMMON_PREFIX_LIB}
make $JOBS
make install
popd

