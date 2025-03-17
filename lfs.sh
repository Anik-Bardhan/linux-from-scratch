#!/bin/bash

export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/mnt/g

if ! grep -q "$LFS" /proc/mounts:  then
    source setupdisk.sh "$LFS_DISK"
fi