#!/bin/sh


cat >/init <<EOF
#!/bin/sh
export PATH="/bin:/sbin"

echo 4 > /proc/sys/kernel/printk
setconsole /dev/tty0 2>/dev/null || true

mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

mkdir -p /newroot /overlay /merged


echo "Waiting usb detection..."
sleep 4

for dev in /dev/sr0 /dev/sd*; do
  echo "$$dev: checking..."
  mount -o ro $$dev /mnt 2>/dev/null || continue
  if [ -f /mnt/boot/rootfs.squashfs ]; then
    echo "Found rootfs on $$dev"

    # mount squashfs first
    mount -t squashfs -o loop /mnt/boot/rootfs.squashfs /newroot || {
      echo "Failed to mount squashfs!"
      exec /bin/init
    }

    # create overlay layer after mounting tmpfs
    mount -t tmpfs tmpfs /overlay
    mkdir -p /overlay/upper /overlay/work

    mount -t overlay overlay \
      -o lowerdir=/newroot,upperdir=/overlay/upper,workdir=/overlay/work \
      /merged || {
        echo "Overlay mount failed!"
        exec /bin/init
      }

    dmesg -n 1
    echo "Switching root..."
    exec switch_root /merged /sbin/init
  fi
  umount /mnt
done

echo "No rootfs found!"
exec /bin/init

EOF
