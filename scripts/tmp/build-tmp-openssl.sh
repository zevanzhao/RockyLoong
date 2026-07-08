#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/openssl.spec --nodeps
pushd $RPMBUILD/openssl-3.5.1-build/openssl-3.5.1

sed -i.bak \
    -e "/EVP_MD_CTX_dup@@OPENSSL/d" \
    -e "/EVP_MD_CTX_dup@OPENSSL_/d" \
    crypto/evp/digest.c

sed -i.bak \
    -e "/EVP_CIPHER_CTX_dup@@OPENSSL_/d" \
    -e "/EVP_CIPHER_CTX_dup@OPENSSL_/d" \
    crypto/evp/evp_enc.c

sed -i.bak \
    -e "/OPENSSL_strncasecmp@@OPENSSL_/d" \
    -e "/OPENSSL_strncasecmp@OPENSSL_/d" \
    -e "/OPENSSL_strcasecmp@@OPENSSL_/d" \
    -e "/OPENSSL_strcasecmp@OPENSSL_/d" \
    crypto/o_str.c

./Configure ${COMMON_PREFIX_LIB} shared zlib linux64-loongarch64
make ${JOBS}
make install
popd
