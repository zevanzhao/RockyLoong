#!/bin/bash
rpmbuild -bp ~/rpmbuild/SPECS/grub2.spec --nodeps
pushd $RPMBUILD/grub2-2.12-build/grub-2.12
autoreconf -fv
sed -i.bak "s/defined(__riscv)/defined(__riscv) || defined(__loongarch__)/g" include/grub/fdt.h
sed -i.bak "s/#if defined(__aarch64__)/#if defined(__aarch64__) ||defined(__loongarch__) /g" include/grub/efi/efi.h
sed -i.bak "/GRUB_PE32_MACHINE_RISCV64;/a\\
#elif defined(__loongarch__)\\
   GRUB_PE32_MACHINE_LOONGARCH64;" grub-core/loader/efi/chainloader.c 
sed -i.bak "/GRUB_EFI_MAX_USABLE_ADDRESS/a\\
#define GRUB_EFI_MAX_ALLOCATION_ADDRESS GRUB_EFI_MAX_USABLE_ADDRESS" include/grub/loongarch64/efi/memory.h

#Add function grub_arch_dl_min_alignment() in loongarch64/dl.c
cat  >> grub-core/kern/loongarch64/dl.c <<EOF
/*
 * Tell the loader what our minimum section alignment is.
 */
grub_size_t
grub_arch_dl_min_alignment (void)
{
#ifdef GRUB_MACHINE_EFI
  return 4096;
#else
  return 1;
#endif
} 
EOF

mkdir -pv build
pushd build
CC=$CC \
    ../configure ${COMMON_HOST_PREFIX} \
    --with-platform=efi --with-utils=host --disable-werror
make $JOBS
make install
popd
popd
