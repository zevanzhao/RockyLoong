#!/bin/bash
pushd /home/rocky/rocky_vm/
echo "$PWD"
mkdir -pv boot/efi/EFI/BOOT/
#/cross-tools/bin/loongarch64-unknown-linux-gnu-grub-mkimage --directory '/tools/lib/grub/loongarch64-efi' \
/bin/grub-mkimage --directory '/usr/lib/grub/loongarch64-efi' \
	       --prefix '(,gpt2)/boot/grub' \
	       --output 'boot/efi/EFI/BOOT/BOOTLOONGARCH64.efi' \
	       --format 'loongarch64-efi' \
	       --compression 'auto' 'ext2' 'part_gpt'

cat >boot/grub/grub.cfg <<EOF
menuentry 'Rocky Linux 10.1'{
	  set root='hd0,gpt2'
	  echo 'Loading Linux kernel...'
	  linux /boot/vmlinuz root=/dev/sdb2 rootdelay=10 swiotlb=16384 rw
	  boot
}
EOF
popd
