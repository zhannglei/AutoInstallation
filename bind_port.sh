#!/usr/bin/env bash

# Assumes 3 nic guest, with first nic virtio
DEVICES=$(lspci |egrep "00:0(4|5|6).0 (Eth|RAM)" |awk '{print $1}')

## Automatically unbind/rebind PCI devices
#modprobe igb_uio
for DEVICE in ${DEVICES}; do
    DEVICE=0000:${DEVICE}
    UIO_DRIVER=/sys/bus/pci/drivers/igb_uio
    SYSFS=/sys/bus/pci/devices/${DEVICE}

    if [ ! -d ${SYSFS} ]; then
        echo "Unable to find device directory: ${SYSFS}"
        exit 1
    fi

    # Add the device to the list of supported devices of the UIO driver
    UEVENT=${SYSFS}/uevent
    PCI_ID=($(cat ${UEVENT} | grep PCI_ID | sed -e 's/^.*=//' | tr ":" " "))
    echo "${PCI_ID[0]} ${PCI_ID[1]}" > ${UIO_DRIVER}/new_id

    # Unbind from the old driver and bind to the new driver
    echo -n ${DEVICE} > ${SYSFS}/driver/unbind
    echo -n ${DEVICE} > ${UIO_DRIVER}/bind
    [ $? == 0 ] && echo "bind port ${DEVICE} success" || "bind port ${DEVICE} failed"
done


