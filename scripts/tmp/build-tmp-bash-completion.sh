#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/bash-completion.spec --nodeps
pushd ${RPMBUILD}/bash-completion-2.11-build/bash-completion-2.11/
./configure ${COMMON_HOST_PREFIX_LIB}
make ${JOBS}
make install
popd
