#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/pcre2.spec --nodeps
pushd ${RPMBUILD}/pcre2-10.44-build/pcre2-10.44/
./configure ${COMMON_HOST_PREFIX_LIB}
make $JOBS
make install
popd
