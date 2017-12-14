. ./config.sh
. ./common_fun.sh
#cd ${PKG_PATH}/x86_64-native-linuxapp-gcc/app/

#pkt_macs=`python ~/cli.py -i $dpdk_ip -m "$my_mac"`
#mac1=`echo $pkt_macs|awk '{print $1}'`
#mac2=`echo $pkt_macs|awk '{print $2}'`

check_icc_and_install

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

    find ${DPDK_FOLDER} -name igb_uio.ko
    if [ $? != "0" ];then
        echo "DPDK is not installed "
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



