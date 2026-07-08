#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/readline.spec --nodeps
pushd ${RPMBUILD}/readline-8.2-build/readline-8.2
./configure ${COMMON_HOST_PREFIX_LIB}
make SHLIB_LIBS="-lncursesw" ${JOBS}
make SHLIB_LIBS="-lncursesw" install
popd
