#!/bin/bash
ROOTFS=${HOME}/rootfs
mkdir -pv $ROOTFS
pushd $ROOTFS

echo "1. copy tools"
cp -a ${SYSDIR}/tools ./
echo "2. make basic directories and symbol links"
mkdir -pv boot dev sys proc tmp etc root home usr/{bin,sbin,lib}
ln -sfv usr/bin/ ./
ln -sfv usr/sbin/ ./
ln -sfv usr/lib/ ./

echo "3. create more symbol links"
ln -sfv /tools/bin/bash bin/
ln -sfv bash bin/sh
ln -sfv /tools/sbin/init sbin/
ln -sfv /tools/sbin/agetty sbin/
ln -sfv /tools/bin/login bin/
ln -sfv /tools/bin/env bin/
ln -sfv /tools/sbin/modprobe sbin/
echo "create extra symbol links"
for fn in xz tar chmod patch mkdir rm gzip bzip2 make install id hostname m4 strip objdump sed pwd grep file cat true awk stty cp env
do
    ln -sfv /tools/bin/${fn} bin
done
ln -sv /tools/sbin/groupadd sbin
ln -sv /tools/sbin/useradd sbin

echo "4. install kernel"
mv -v tools/boot/* boot/
mkdir -pv lib/modules
mv -v tools/lib/modules/* lib/modules

echo "5. set /var, /run and /tmp"
mv tools/var ./
ln -sfv ../var tools/var
mv var/run ./
ln -sfv ../run var/
rm -rf var/tmp
ln -sfv ../tmp var/

echo "6. create log files"
mkdir -pv var/log
touch var/log/{btmp,lastlog,wtmp}
chmod -v 664 var/log/lastlog

echo "7. create /etc/passwd"
cat > etc/passwd << "EOF"
root::0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
daemon:x:6:6:Daemon User:/dev/null:/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/var/run/dbus:/bin/false
lp:x:9:9:Print Service User:/var/spool/cups:/bin/false
polkitd:x:27:27:PolicyKit Daemon Owner:/etc/polkit-1:/bin/false
rsyncd:x:46:46:rsyncd Daemon:/home/rsync:/bin/false
sshd:x:50:50:sshd PrivSep:/var/lib/sshd:/bin/false
lightdm:x:65:65:Lightdm Daemon:/var/lib/lightdm:/bin/false
sddm:x:66:66:Simple Desktop Display Manager:/var/lib/sddm:/sbin/nologin
colord:x:71:71:Color Daemon Owner:/var/lib/colord:/bin/false
systemd-bus-proxy:x:72:72:systemd Bus Proxy:/:/bin/false
systemd-journal-gateway:x:73:73:systemd Journal Gateway:/:/bin/false
systemd-journal-remote:x:74:74:systemd Journal Remote:/:/bin/false
systemd-journal-upload:x:75:75:systemd Journal Upload:/:/bin/false
systemd-network:x:76:76:systemd Network Management:/:/bin/false
systemd-resolve:x:77:77:systemd Resolver:/:/bin/false
systemd-timesync:x:78:78:systemd Time Synchronization:/:/bin/false
systemd-coredump:x:79:79:systemd Core Dumper:/:/bin/false
systemd-oom:x:80:80:systemd Userspace OOM Killer:/:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF

echo " create /etc/group"
cat > etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
lpadmin:x:19:
systemd-journal:x:23:
input:x:24:
polkitd:x:27:
mail:x:34:
rsyncd:x:46:
sshd:x:50:
kvm:x:61:
lightdm:x:65:
sddm:x:66:
colord:x:71:
systemd-bus-proxy:x:72:
systemd-journal-gateway:x:73:
systemd-journal-remote:x:74:
systemd-journal-upload:x:75:
systemd-network:x:76:
systemd-resolve:x:77:
systemd-timesync:x:78:
systemd-coredump:x:79:
systemd-oom:x:80:
saslauth:x:81:
wheel:x:97:
nogroup:x:99:
users:x:1000:
EOF

echo "8. set hostname"
echo "RockyLoong" >etc/hostname

echo "9. set hosts"
cat > etc/hosts << "EOF"
127.0.0.1 RockyLoong localhost
::1       localhost ip6-localhost ip6-loopback
ff02::1   ip6-allnodes
ff02::2   ip6-allrouters
EOF

echo "10. resolv.conf"
ln -sfv /tools/lib/systemd/resolv.conf etc/resolv.conf

echo "11. create tools/etc/inputrc"
cat > tools/etc/inputrc << "EOF"
set horizontal-scroll-mode Off
set meta-flag On
set input-meta On
set convert-meta Off
set output-meta On
set bell-style none
"\eOd": backward-word
"\eOc": forward-word
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert
"\eOH": beginning-of-line
"\eOF": end-of-line
"\e[H": beginning-of-line
"\e[F": end-of-line
EOF

echo "12. create /etc/profile"
cat >etc/profile <<"EOF"
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
export INPUTRC=/tools/etc/inputrc
export PS1='[\u@\h \W]\$ '
export PATH=/usr/sbin:/usr/bin:/tools/sbin:/tools/bin 
EOF

echo "13. install grub modules"
mkdir -pv boot/grub
cp -av tools/lib/grub/loongarch64-efi boot/grub

echo "14. setup systemd"
systemd-machine-id-setup --root=${PWD}

if [ ! -d tools/etc/systemd/system/getty.target.wants ];
then
    mkdir -pv tools/etc/systemd/system/getty.target.wants
    ln -sfv /tools/lib/systemd/system/console-getty.service \
       tools/etc/systemd/system/getty.target.wants/
fi

echo "15. lsb"
cat > etc/lsb-release << "EOF"
DISTRIB_ID="Rocky Linux for LoongArch64"
DISTRIB_RELEASE="10.1"
DISTRIB_CODENAME="RockyLoong"
DISTRIB_DESCRIPTION="Rocky Linux for LoongArch64"
EOF

echo "16. os-release"
cat > etc/os-release << "EOF"
NAME="Rocky Linux for LoongArch64"
VERSION="10.1"
ID=RockyLoong
PRETTY_NAME="Rocky Linux for LoongArch64 10.1"
VERSION_CODENAME="RockyLoong"
EOF

#copy the firmware
echo "17. copy the firmware"
cp -rv $DOWNLOADDIR/firmware lib/

echo "18. config PAM"
mkdir -pv etc/pam.d
cat > etc/pam.d/system-account << "EOF"
account   required    pam_unix.so
EOF

cat > etc/pam.d/system-auth << "EOF"
auth      required    pam_unix.so
EOF

cat > etc/pam.d/system-session << "EOF"
session   required    pam_unix.so
EOF
cat > etc/pam.d/system-password << "EOF"
password  required    pam_unix.so       sha512 shadow try_first_pass
EOF
mkdir -pv etc/pam.d

cat > etc/pam.d/system-account << "EOF"
account   required    pam_unix.so
EOF

cat > etc/pam.d/system-auth << "EOF"
auth      required    pam_unix.so
EOF

cat > etc/pam.d/system-session << "EOF"
session   required    pam_unix.so
EOF
cat > etc/pam.d/system-password << "EOF"
password  required    pam_unix.so       sha512 shadow try_first_pass
EOF

cat > etc/pam.d/other << EOF
auth            required        pam_unix.so     nullok
account         required        pam_unix.so
session         required        pam_unix.so
password        required        pam_unix.so     nullok
EOF

echo "19 create grub.cfg"
cat > boot/grub/grub.cfg <<EOF
menuentry ' Rocky Loong 10.1 for LoongArch64' {
set root='hd0,gpt2'
insmod gzio
if [ x$grub_platform = xxen ]; then insmod xzio; insmod lzopio; fi
insmod part_gpt
insmod ext2
echo 'Loading Linux Kernel ...'
linux /boot/vmlinuz root=/dev/vda2 rootdelay=5 rw loglevel=7 debug console=ttyS0
boot
}
EOF
echo "Done!"
popd
