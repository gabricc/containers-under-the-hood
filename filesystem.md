# mount overlay fs
mount -t overlay overlay -o lowerdir=/mnt/image,upperdir=/mnt/upper,workdir=/mnt/work /mnt/merged
# create required namespaces
unshare --mount --uts --ipc --net --pid --fork /bin/bash

mkdir /mnt/merged/old
pivot_root /mnt/merged/ /mnt/merged/old/
echo "container-centos" > /etc/hostname
hostname -F /etc/hostname
exec bash
mount -t proc proc /proc
mount -t devtmpfs udev /dev
umount -a
umount -l /old