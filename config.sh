#!/usr/bin/env bash

#folder
export BASE_FOLDER=/root/APP
export SCRIPT_FOLDER=${BASE_FOLDER}/Configs/Preinstall_script/Auto_Installation
export DPDK_FOLDER=${BASE_FOLDER}/Utilities/DPDK
export PKTGEN_FOLDER=${BASE_FOLDER}/Utilities/Pktgen
export RPM_FOLDER=${BASE_FOLDER}/Configs/Preinstall_RPMs
export LICENSE_FOLDER=${BASE_FOLDER}/ICC
export ICC_FOLDER=${BASE_FOLDER}/ICC

#mac file
export MY_MAC_FILE=${SCRIPT_FOLDER}/my_mac.txt
export OTHER_MAC_FILE=${SCRIPT_FOLDER}/other_mac.txt

#cmd line
export TESTPMD_CMD="./testpmd -c 0xe -n 3 -- -i --nb-cores=2 --nb-ports=2 --eth-peer=0,\$mac1 --eth-peer=1,\$mac2"
