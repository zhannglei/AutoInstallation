#!/usr/bin/env bash
. ./config.sh

. ./install_license.sh

icc -v >> /dev/null
if [ $? == 0 ];then
    echo "ICC has already installed"
else
    cd ${ICC_FOLDER}
    [ ! -d parallel_studio_xe_2017_update1 ] && tar -xvf parallel_studio_xe_2017_update1.tgz && sleep 10
    cd parallel_studio_xe_2017_update1
    ${SCRIPT_FOLDER}/install_icc.exp
    sleep 10
    source /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh  intel64
    icc -v >> /dev/null
    if [ $? == 0 ];then
        echo "ICC is installed successfully."
    else
        echo "ICC is installed failed."
    fi
fi

