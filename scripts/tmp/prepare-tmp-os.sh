#~/.bashrc
echo "Set ~/.bashrc"
cat >> ~/.bashrc <<EOF
export CC="\${CROSS_TARGET}-gcc"
export CXX="\${CROSS_TARGET}-g++"
export AR="\${CROSS_TARGET}-ar"
export AS="\${CROSS_TARGET}-as"
export RANLIB="\${CROSS_TARGET}-ranlib"
export LD="\${CROSS_TARGET}-ld"
export STRIP="\${CROSS_TARGET}-strip"
export COMMON_HOST_PREFIX="--host=\${CROSS_TARGET} --prefix=/tools"
export COMMON_PREFIX_LIB="--prefix=/tools/ --libdir=/tools/lib64"
export COMMON_HOST_PREFIX_LIB="\${COMMON_HOST_PREFIX} --libdir=/tools/lib64"
EOF
#create meson-cross.txt
echo "Create meson-cross.txt"
pushd /cross-tools/
cat >meson-cross.txt <<EOF
[binaries]
c = '${CROSS_TARGET}-gcc'
cpp = '${CROSS_TARGET}-g++'
ar = '${CROSS_TARGET}-ar'
strip = '${CROSS_TARGET}-strip'
pkgconfig = '/cross-tools/bin/pkg-config'
[properties]
sys_root='${SYSDIR}'
[hostmachine]
system='linux'
cpu_family='loongarch64'
cpu='loongarch64'
endian='little'
EOF
source ~/.bash_profile
export 
echo "Done!"
