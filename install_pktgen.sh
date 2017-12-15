#!/usr/bin/env bash
. ./config.sh
. ./common_fun.sh

check_dpdk_and_install

cd ${PKTGEN_FOLDER}
pktgen_pkg=`ls -F |grep "pktgen.*/$"`
pktgen_tar=`ls -F |grep "pktgen.*[^/]$"`
[ "$pktgen_pkg" == "" ] && tar -xvf $pktgen_tar
pktgen_pkg=`ls -F |grep "pktgen.*/$"`

cd $pktgen_pkg

if [ -f app/x86_64-native-linuxapp-icc/pktgen ];then
    echo "Pktgen has already installed."
else
    rpm -q libpcap-devel-1.5.3-8.el7.x86_64
    if [ $? != 0 ];then
        echo "libpcap is not installed."
        exit 1
    fi

    make

    if [ -f app/x86_64-native-linuxapp-icc/pktgen ];then
        echo "Pktgen is installed successfully."
    else
        echo "Pktgen is installed failed."
        exit 1
    fi
fi



