#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/rust.spec --nodeps
pushd ${RPMBUILD}/rust-1.88.0-build/rustc-1.88.0-src
unset  PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/tools/lib64/pkgconfig
export RUSTFLAGS="-A dead_code"
export RUST_BACKTRACE=1
cp -r ${HOME}/build/llvm-project-rustc-1.88.0/* src/llvm-project
./configure ${COMMON_HOST_PREFIX} \
	    --sysconfdir=/tools/etc \
	    --local-rust-root=$HOME/build/rust \
	    --llvm-root=/usr/ \
	    --disable-llvm-static-stdcpp \
	    --disable-llvm-bitcode-linker \
	    --disable-lld \
	    --set build.build-stage=2 \
	    --set build.doc-stage=2 \
	    --set build.install-stage=2 \
	    --set build.test-stage=2 \
	    --set build.optimized-compiler-builtins=false \
	    --set rust.llvm-tools=false \
	    --enable-extended \
	    --tools=cargo,clippy,rust-analyzer,rustfmt,src \
	    --enable-vendor

make HOST_CC="gcc" CC="$CC" HOST_CXX="g++" CXX="$CXX" ${JOBS}
make HOST_CC="gcc" CC="$CC" HOST_CXX="g++" CXX="$CXX" install
popd
