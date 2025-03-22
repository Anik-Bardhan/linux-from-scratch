LFS_DISK="$1"

sudo fdisk "$LFS_DISK" << EOF
o
n
p
1

+100M
a
n
p
2


p
w
q
EOF

sudo umount "${LFS_DISK}1"
sudo umount "${LFS_DISK}2"

sudo mkfs -t ext2 -F "${LFS_DISK}1"
sudo mkfs -t ext2 -F "${LFS_DISK}2"