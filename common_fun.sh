function mount_huge(){
    [ ! -d /mnt/huge ] && mkdir -p /mnt/huge
    mount |grep /mnt/huge ||  mount -t hugetlbfs nodev /mnt/huge
    echo 2048 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
}

#
#function unbind_dpdk(){
#    DPDK_BIND_TOOL=$1
#    eth_ids=`$DPDK_BIND_TOOL --status |egrep -i "network devices$|network devices using dpdk" -A4 |grep "^0000" |awk '{print $1}'`
#    for eth_id in $eth_ids; do
#        $DPDK_BIND_TOOL -b virtio-pci $eth_id
#        [ $? == "0" ] && echo "unbind $eth_id success" || echo "unbind $eth_id fail"
#    done
#    eth_ids=`$DPDK_BIND_TOOL --status |egrep -i "network devices$|network devices using dpdk" -A4 |grep "^0000" |awk '{print $1}'`
#    for eth_id in $eth_ids; do
#        $DPDK_BIND_TOOL -b virtio-pci $eth_id
#        [ $? == "0" ] && echo "unbind $eth_id success" || echo "unbind $eth_id fail"
#    done
#
#}

function get_mac_address(){
#get mac address
    eths=`ifconfig -a |egrep ^e.*flags= |grep -v eth0 |awk -F : '{print $1}'`
    my_mac=""
    for eth in $eths; do
        net=`ethtool -i $eth |grep driver |awk '{print $2}'`
        mac=`ifconfig $eth |grep ether |awk '{print $2}'`
        my_mac="$my_mac $mac"
    done
    echo $my_mac
}

function bind_dpdk(){
    DPDK_BIND_TOOL=$1
    #bind dpdk
    eth_ids=`$DPDK_BIND_TOOL --status |egrep -i "network devices using kernel" -A4 |grep "^0000:00:0[4|5|6]" |awk '{print $1}'`
    for eth_id in $eth_ids; do
        $DPDK_BIND_TOOL -b igb_uio $eth_id
        [ $? == "0" ] && echo "bind $eth_id success" || echo "bind $eth_id fail"
    done
}
