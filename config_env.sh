#!/usr/bin/env bash

diff extlinux.conf /boot/extlinux.conf >/dev/null
if [ $? != 0 ]; then
    read -p "Huge page setting is not right,Do you want to fix it and reboot [y/n]:" choose
    if [ "$choose" = "y" ] || [ "$choose" = "Y" ];then
        cp extlinux.conf /boot/extlinux.conf
        echo "System will reboot after 5 seconds."
        sleep 5
        reboot
    fi
else
    echo "Huge page setting is right, no need to reboot."
fi