#!/usr/bin/env bash

. ./config.sh
. ./common_fun.sh

check_icc_and_install

cd ${DPDK_FOLDER}
dpdk_pkg=`ls -F |grep dpdk.*/$`
dpdk_tar=`ls -F |grep dpdk.*[^/]$`
[ "$dpdk_pkg" == "" ] && tar -xvf $dpdk_tar
dpdk_pkg=`ls -F |grep dpdk.*/$`
export RTE_SDK=$PWD/${dpdk_pkg}
export RTE_TARGET=x86_64-native-linuxapp-icc
cd $dpdk_pkg

if [ -f x86_64-native-linuxapp-icc/kmod/igb_uio.ko ];then
    echo "DPDK has already installed."
else

    rpm -q numactl-devel-2.0.9-6.el7_2.x86_64
    if [ $? != 0 ];then
        echo "numactl is not installed."
        exit 1
    fi
    make install T=x86_64-native-linuxapp-icc
    if [ -f x86_64-native-linuxapp-icc/kmod/igb_uio.ko ];then
        echo "DPDK is installed successfully."
    else
        echo "DPDK is installed failed."
        exit 1
    fi
fi

#modprobe uio
#lsmod |grep igb_uio >> /dev/null || insmod x86_64-native-linuxapp-icc/kmod/igb_uio.ko && echo "igb_uio installed"
#[ -d tools ] && DPDK_BIND_TOOL=${RTE_SDK}tools/dpdk-devbind.py
#[ -d usertools ] && DPDK_BIND_TOOL=${RTE_SDK}usertools/dpdk-devbind.py

#unbind_dpdk $DPDK_BIND_TOOL
#sleep 3

#


#mount_huge
#my_mac=`get_mac_address`
#bind_dpdk $DPDK_BIND_TOOL

#pkt_macs=`python ~/test/ser.py -m "$my_mac"`
#mac1=`echo $pkt_macs|awk '{print $1}'`
#mac2=`echo $pkt_macs|awk '{print $2}'`
#




