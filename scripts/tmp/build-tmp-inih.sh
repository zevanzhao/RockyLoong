#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/inih.spec --nodeps
pushd ${RPMBUILD}/inih-58-build/inih-r58/
mkdir build
pushd build
meson ${COMMON_PREFIX_LIB} \
      --buildtype=release --cross-file=/cross-tools/meson-cross.txt ..
ninja
ninja install
popd
popd
