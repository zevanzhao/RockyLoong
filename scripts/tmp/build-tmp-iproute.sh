#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/iproute.spec --nodeps
pushd ${RPMBUILD}/iproute-6.14.0-build/iproute2-6.14.0
sed -i "/ARPD/d" Makefile
./configure
make CC="${CC}" HOSTCC="gcc" PREFIX=/tools LIBDIR=/tools/lib64/ \
     KERNEL_INCLUDE=/toools/include \
     NETNS_RUN_DIR=/run/netns \
     SBINDIR=/tools/sbin/ \
     CONFDIR=/tools/etc \
     ${JOBS}
make CC="${CC}" HOSTCC="gcc" PREFIX=/tools LIBDIR=/tools/lib64/\
     KERNEL_INCLUDE=/toools/include \
     NETNS_RUN_DIR=/run/netns \
     SBINDIR=/tools/sbin/ \
     CONFDIR=/tools/etc \
     install
popd
