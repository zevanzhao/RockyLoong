#~/.bash_profile
echo "Set ~/.bash_profile"
cat > ~/.bash_profile <<EOF
exec env -i HOME=${HOME} TERM=${TERM} PS1='\u@\h:\w\$ ' /bin/bash
EOF

#~/.bashrc
echo "Set ~/.bashrc"
cat > ~/.bashrc <<EOF
set +h
umask 022
export SYSDIR="\${HOME}/rocky_loong64"
export DOWNLOADDIR="\${SYSDIR}/sources"
export SRPMS="\${SYSDIR}/srpms"
export BUILDDIR="\${SYSDIR}/build/"
export RPMBUILD="\${HOME}/rpmbuild/BUILD/"
export LC_ALL=POSIX
export PATH=\${SYSDIR}/cross-tools/bin:/bin/:/usr/bin/
export CROSS_BUILD=loongarch64-debian-linux-gnu
export CROSS_HOST=loongarch64-cross-linux-gnu
export CROSS_TARGET=loongarch64-unknown-linux-gnu
export MABI="lp64d"
export BUILD64="-mabi=lp64d"
export JOBS=-j8
unset CFLAGS
unset CXXFLAGS
#export CFLAGS="-O3 -std=gnu17"
#export CXXFLAGS="-O3"
#export CC="\${CROSS_TARGET}-gcc"
#export CXX="\${CROSS_TARGET}-g++"
#export AR="\${CROSS_TARGET}-ar"
#export AS="\${CROSS_TARGET}-as"
#export RANLIB="\${CROSS_TARGET}-ranlib"
#export LD="\${CROSS_TARGET}-ld"
#export STRIP="\${CROSS_TARGET}-strip"
#export COMMON_HOST_PREFIX="--host=\${CROSS_TARGET} --prefix=/tools"
#export COMMON_PREFIX_LIB="--prefix=/tools/ --libdir=/tools/lib64"
#export COMMON_HOST_PREFIX_LIB="\${COMMON_HOST_PREFIX} --libdir=/tools/lib64"
EOF
source ~/.bash_profile
export 
echo "Done!"
