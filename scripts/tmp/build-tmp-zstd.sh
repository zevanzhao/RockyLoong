#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/zstd.spec --nodeps 
pushd ${RPMBUILD}/zstd-1.5.5-build/zstd-1.5.5/
make PREFIX=/tools/ LIBDIR=/tools/lib64/ ${JOBS}
make PREFIX=/tools/ LIBDIR=/tools/lib64/ install
popd
