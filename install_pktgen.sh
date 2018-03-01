#!/usr/bin/env bash
. ./config.sh
. ./common_fun.sh

check_rpm_and_install
#check_dpdk_and_install
cd ${DPDK_FOLDER_FOR_PKTGEN}
INSTALL_FOLDER=${INSTALL_FOLDER2}
[ ! -d ${INSTALL_FOLDER} ] && mkdir ${INSTALL_FOLDER}
dpdk_pkg=`ls -F ${INSTALL_FOLDER} |grep dpdk.*/$`
dpdk_tar=`ls -F |grep dpdk.*[^/]$`
[ "$dpdk_pkg" == "" ] && tar -xvf $dpdk_tar -C ${INSTALL_FOLDER}
dpdk_pkg=`ls -F ${INSTALL_FOLDER} |grep "dpdk.*/$"`
export RTE_SDK=${INSTALL_FOLDER}/${dpdk_pkg}
export RTE_TARGET=x86_64-native-linuxapp-gcc
cd ${INSTALL_FOLDER}
cd ${dpdk_pkg}
if [ -f ${RTE_TARGET}/app/testpmd ];then
    echo "DPDK has already installed."
else
    rpm -q numactl-devel-2.0.9-6.el7_2.x86_64
    if [ $? != 0 ];then
        echo "numactl is not installed."
        exit 1
    fi

    cp ${SCRIPT_FOLDER}/patch/*.patch .
    patch -p 1 < *.patch
    make install T=${RTE_TARGET}
fi

if [ -f ${RTE_TARGET}/app/testpmd ];then
    echo "DPDK is installed successfully."
else
    echo "DPDK is installed failed."
    exit 1
fi

cd ${PKTGEN_FOLDER}
pktgen_pkg=`ls -F ${INSTALL_FOLDER} |grep "pktgen.*/$"`
pktgen_tar=`ls -F |grep "pktgen.*[^/]$"`
[ "$pktgen_pkg" == "" ] && tar -xvf $pktgen_tar -C ${INSTALL_FOLDER}
pktgen_pkg=`ls -F ${INSTALL_FOLDER} |grep "pktgen.*/$"`
dpdk_pkg=`ls -F ${INSTALL_FOLDER} |grep "dpdk.*/$"`
#export RTE_SDK=${INSTALL_FOLDER}/${dpdk_pkg}
#export RTE_TARGET=x86_64-native-linuxapp-gcc

cd ${INSTALL_FOLDER}
cd ${pktgen_pkg}

if [ -f app/${RTE_TARGET}/pktgen ];then
    echo "Pktgen has already installed."
else
    rpm -q libpcap-devel-1.5.3-8.el7.x86_64
    if [ $? != 0 ];then
        echo "libpcap is not installed."
        exit 1
    fi

    make

    if [ -f app/${RTE_TARGET}/pktgen ];then
        echo "Pktgen is installed successfully."
    else
        echo "Pktgen is installed failed."
        exit 1
    fi
fi

cp Pktgen.lua app/${RTE_TARGET}/


