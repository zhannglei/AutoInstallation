#!/usr/bin/env bash
. ./config.sh
. ./common_fun.sh
choose_info="
*****************************************
*    Wireless BKC Auto Installation     *
*****************************************

1. Install all packages and configure BKC environment (RPM dependency, ICC with licenses, DPDK, PKTGEN, extlinux.conf)
2. Install RPM dependency Only
3. Install ICC with licenses Only
4. Install DPDK Only
5. Install PKTGEN
6. System configuration to update extlinux.conf
0. Exit.
Input you choice:"

while [ 1 ]; do
    read -p "$choose_info" choose
    case "$choose" in
        "0")
            exit 1
            ;;
        "1")
            cd ${SCRIPT_FOLDER}
            . ./install_rpm.sh
            cd ${SCRIPT_FOLDER}
            . ./install_icc.sh
            cd ${SCRIPT_FOLDER}
            . ./install_dpdk.sh
            cd ${SCRIPT_FOLDER}
            . ./install_pktgen.sh
            cd ${SCRIPT_FOLDER}
            . ./config_env.sh
            break
            ;;
        "2")
            cd ${SCRIPT_FOLDER}
            . ./install_rpm.sh
            ;;
        "3")
            cd ${SCRIPT_FOLDER}
            . ./install_icc.sh
            ;;
        "4")
            cd ${SCRIPT_FOLDER}
            . ./install_dpdk.sh
            ;;
        "5")
            cd ${SCRIPT_FOLDER}
            . ./install_pktgen.sh
            ;;
        "6")
            cd ${SCRIPT_FOLDER}
            . ./config_env.sh
            ;;
        "*")
            echo "Your choose is not match, please try again."
    esac
done
