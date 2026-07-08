#!/bin/bash
pushd ${DOWNLOADDIR}
wget "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess" -O config.guess
wget "https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub" -O config.sub
popd
