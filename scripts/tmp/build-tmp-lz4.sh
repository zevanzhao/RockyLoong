#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/lz4.spec --nodeps 
pushd ${RPMBUILD}/lz4-1.9.4-build/lz4-1.9.4
make PREFIX=/tools/ LIBDIR=/tools/lib64/ ${JOBS}
make PREFIX=/tools/ LIBDIR=/tools/lib64/ install
popd
