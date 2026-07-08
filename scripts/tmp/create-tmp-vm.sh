#!/bin/bash
#create qcow2 image
ROOTFS_DIR="/home/rocky/rootfs"
VM_DIR="/home/rocky/rocky_vm"
IMAGE="/home/rocky/rocky_vm.qcow2"
DEVICE="/dev/nbd0"
qemu-img create -f qcow2 ${IMAGE} 100G
modprobe nbd max_part=8
qemu-nbd -c ${DEVICE} ${IMAGE}
sleep 2
lsblk ${DEVICE}
EFI_SIZE="+100M"
EFI_CODE="EF00"
ROOT_CODE="8300"
EFI_MKFS_OPTS=""
echo "WARNING: This script will erase all data on $DEVICE. Press Ctrl+C to cancel, or press Enter to continue..."
read
# 1. Check if device exists
if [ ! -b "$DEVICE" ]; then
  echo "Error: Device $DEVICE does not exist or is not a block device."
  exit 1
fi
# 2. Use sgdisk to create a new GPT partition table and partitions
echo "Creating GPT partition table and partitions on $DEVICE..."
/sbin/sgdisk \
  --clear \
  --new=1::${EFI_SIZE} \
  --typecode=1:${EFI_CODE} \
  --change-name=1:"EFI" \
  --new=2::-0 \
  --typecode=2:${ROOT_CODE} \
  --change-name=2:"Root" \
  --print \
  "$DEVICE"

if [ $? -ne 0 ]; then
    echo "Error: sgdisk partitioning operation failed."
    exit 1
fi

# 3. Wait for the kernel to re-read the partition table
echo "Waiting for the kernel to recognize the new partitions..."
/sbin/partprobe "$DEVICE"

# Wait a moment to ensure partition device files are created
sleep 2

# 4. Check if partitions were successfully created
PART_EFI="${DEVICE}p1"
PART_ROOT="${DEVICE}p2"

if [ ! -b "$PART_EFI" ] || [ ! -b "$PART_ROOT" ]; then
  echo "Error: Could not find the created partitions $PART_EFI or $PART_ROOT."
  lsblk "$DEVICE"
  exit 1
fi

# 5. Format partitions
echo "Formatting $PART_EFI as FAT32..."
mkfs.fat -F 32 $EFI_MKFS_OPT "$PART_EFI"

if [ $? -ne 0 ]; then
  echo "Error: Formatting EFI partition $PART_EFI failed."
  exit 1
fi

echo "Formatting $PART_ROOT as ext4..."
mkfs.ext4 "$PART_ROOT"

if [ $? -ne 0 ]; then
  echo "Error: Formatting root partition $PART_ROOT failed."
  exit 1
fi

echo "Partitioning and formatting completed!"
echo "EFI Partition: $PART_EFI"
echo "Root Partition: $PART_ROOT"
lsblk "$DEVICE"
echo "BLK ID"
/sbin/blkid "$PART_EFI"
/sbin/blkid "$PART_ROOT"

# 1. Check if configuration variables are set
if [ -z "$VM_DIR" ] || [ -z "$ROOTFS_DIR" ]; then
  echo "Error: VM_DIR or ROOTFS_DIR configuration variable is empty."
  exit 1
fi

# 3. Check if the partition devices exist
if [ ! -b "$PART_ROOT" ] || [ ! -b "$PART_EFI" ]; then
  echo "Error: Partition devices $PART_ROOT or $PART_EFI do not exist."
  lsblk "$DEVICE"
  exit 1
fi

# 4. Create mount points if they don't exist
echo "Creating mount point directories..."
mkdir -pv "$VM_DIR"

# 5. Mount the root partition
echo "Mounting root partition $PART_ROOT to $VM_DIR..."
mount "$PART_ROOT" "$VM_DIR"

if [ $? -ne 0 ]; then
  echo "Error: Failed to mount root partition $PART_ROOT to $VM_DIR."
  exit 1
fi

# 6. Copy files from rootfs to the mounted VM directory
echo "Copying files from $ROOTFS_DIR to $VM_DIR..."
cp -av "$ROOTFS_DIR"/. "$VM_DIR"/

if [ $? -ne 0 ]; then
  echo "Error: Failed to copy files from $ROOTFS_DIR to $VM_DIR."
  umount "$VM_DIR" # Attempt to unmount on failure
  exit 1
fi

# 7. Create the EFI mount point inside the VM's filesystem
EFI_MOUNT_POINT="$VM_DIR/boot/efi"
echo "Creating EFI mount point directory $EFI_MOUNT_POINT..."
mkdir -pv "$EFI_MOUNT_POINT"

# 8. Mount the EFI partition
echo "Mounting EFI partition $PART_EFI to $EFI_MOUNT_POINT..."
mount "$PART_EFI" "$EFI_MOUNT_POINT"

if [ $? -ne 0 ]; then
  echo "Error: Failed to mount EFI partition $PART_EFI to $EFI_MOUNT_POINT."
  # Clean up: unmount the root partition before exiting
  umount "$VM_DIR"
  exit 1
fi

echo "Mounting and copying completed successfully!"
echo "Root partition ($PART_ROOT) is mounted at: $VM_DIR"
echo "EFI partition ($PART_EFI) is mounted at: $EFI_MOUNT_POINT"

#
