#!/usr/bin/env bash

. ./config.sh
. ./common_fun.sh

processor=`cat /proc/cpuinfo  |grep -c  processor`
if [ $processor -lt 12 ];then
    echo "cpu count is $processor, please check"
    break
fi

hugepages=`cat /proc/meminfo  |grep -i hugepages_total |awk '{print $2}'`
if [ "$hugepages" -lt 10 ];then
    echo "hugepages is $hugepages, please check"
    break
fi

cd ${FLEXRAN_FOLDER}
mkdir -p ${FLEXRAN_SRC}

flexran_pkg=`ls ${FLEXRAN_FOLDER} |grep -i flexran`
tar -xvf ${flexran_pkg} -C ${FLEXRAN_SRC}

cd ${FLEXRAN_SRC}

sed -i '/echo -n /d' ./extract.sh
sed -i '/read install_path/d' ./extract.sh
sed -i '/more Intel_OBL_Software_Clickwrap_License.txt/d' ./*.sh
. ${SCRIPT_FOLDER}/flexran/auto_extract.sh
. ${SCRIPT_FOLDER}/flexran/r_buildall.sh
sleep 2

#cd ${FLEXRAN_SRC}
#${SCRIPT_FOLDER}/flexran/create_re_bin.sh

