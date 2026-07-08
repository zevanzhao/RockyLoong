#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/vim.spec --nodeps
pushd ${RPMBUILD}/vim-9.1.083-build/vim91
./configure ${COMMON_HOST_PREFIX} --with-tlib=ncurses LIBS="-ltinfo"
make ${JOBS}
make install
ln -sv vim /tools/bin/vi
cat >/tools/etc/vimrc <<"EOF"
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1
set nocompatible
set backspace=2
set mouse=a

syntax on

if (&term == "xterm") || (&term == "putty")
  set background=dark
endif
EOF
popd
