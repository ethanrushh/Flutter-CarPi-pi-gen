# Flutter-CarPi pi-gen

Tool for creating images of Flutter-CarPi. WIP.

## Usage

To install dependencies for building:
```
apt install coreutils quilt parted qemu-user-binfmt debootstrap zerofree zip \
dosfstools e2fsprogs libarchive-tools libcap2-bin grep rsync xz-utils file git curl bc \
gpg pigz xxd arch-test bmap-tools kmod
```

To Build:
```
sudo ./build.sh -c config
```
This will take some time. If successful, you should find your ready to go .img file in deploy/<date>-carpi-os-configured.img


## Disclaimer
This project is a WIP. Use at your own risk. 
