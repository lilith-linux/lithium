#!/bin/sh


cat >/etc/fstab <<EOF
# /etc/fstab (in rootfs.squashfs)
proc            /proc           proc    defaults            0 0
sysfs           /sys            sysfs   defaults            0 0
devtmpfs        /dev            devtmpfs defaults           0 0
tmpfs           /tmp            tmpfs   defaults,noatime,mode=1777 0 0
EOF


