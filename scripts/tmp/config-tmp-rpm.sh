#!/bin/bash
pushd /tools/lib/rpm
for i in $(find -name "macros")
do
    sed -i "s@/tools@/usr@g" $i
    sed -i "/%_sysconfdir/s@%{_prefix}@@g" $i
    sed -i "/%_localstatedir/s@%{_prefix}@@g" $i
    sed -i "/%_var/s@%{_prefix}@@g" $i
    sed -i "/%_sharedstatedir/s@%{_prefix}/com@/var/lib@g" $i
done
sed -i 's@/tools@/usr@g' macros.d/*
sed -i "s@loongarch64-unknown-linux-gnu-@@g" macros
popd
