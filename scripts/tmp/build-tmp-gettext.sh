#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/gettext.spec --nodeps
pushd ${RPMBUILD}/gettext-0.22.5-build/gettext-0.22.5/
sed -e 's/\(gl_cv_libxml_force_included=\)no/\1yes/' \
    -i libtextstyle/configure
./configure ${COMMON_HOST_PREFIX_LIB} --disable-static
make ${JOBS}
make install
popd
