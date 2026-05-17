#!/bin/bash -e
set -euo pipefail

cp -r files/Flutter-CarPi "$ROOTFS_DIR/home/pi/"

mkdir -p "$ROOTFS_DIR/home/pi/.config/systemd/user/"
cp files/carpi.service "$ROOTFS_DIR/home/pi/.config/systemd/user/"

cp files/can0.service "$ROOTFS_DIR/etc/systemd/system/"

sudo mkdir -p "$ROOTFS_DIR/etc/wireplumber/wireplumber.conf.d"
cp files/50-bluez-no-seat.conf "$ROOTFS_DIR/etc/wireplumber/wireplumber.conf.d/"
cp files/50-disable-suspend-all-alsa.conf "$ROOTFS_DIR/etc/wireplumber/wireplumber.conf.d/"


on_chroot <<'EOF'

sed -i 's/^#AutoEnable=true/AutoEnable=false/' /etc/bluetooth/main.conf

git clone https://github.com/flutter-elinux/flutter-elinux.git /opt/flutter-elinux
chown -R pi:pi /opt/flutter-elinux
chown -R pi:pi /home/pi/Flutter-CarPi
chown -R pi:pi /home/pi/.config
chown pi:pi /home/pi/.config/systemd/user/carpi.service

systemctl enable can0.service

su - pi <<'PIEOF'

export PATH=$PATH:/opt/flutter-elinux/bin
echo 'export PATH=$PATH:/opt/flutter-elinux/bin' >> ~/.bashrc

STAGE3_ORIG_DIR=$(pwd)

cd /home/pi/Flutter-CarPi
./build.sh

cd "$STAGE3_ORIG_DIR"

mkdir -p ~/.config/systemd/user

systemctl --user enable carpi.service

PIEOF

EOF
