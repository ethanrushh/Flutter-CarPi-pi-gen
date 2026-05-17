#!/bin/bash -e

on_chroot <<EOF
echo "Hi, CarPi OS" > /home/pi/hello
EOF
