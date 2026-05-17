#!/bin/bash -e

on_chroot << EOF
usermod -aG render pi
groupadd -f gpio
usermod -aG gpio pi
EOF

install -m 644 files/99-gpio.rules "$ROOTFS_DIR/etc/udev/rules.d/99-gpio.rules"

mkdir -p "$ROOTFS_DIR/var/lib/systemd/linger"
touch "$ROOTFS_DIR/var/lib/systemd/linger/pi"
