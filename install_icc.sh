#!/usr/bin/env bash
. ./config.sh

. ./install_license.sh

cd ${ICC_FOLDER}
[ ! -d parallel_studio_xe_2017_update1 ] && tar -xvf parallel_studio_xe_2017_update1.tgz && sleep 10
cd parallel_studio_xe_2017_update1
if [ ! -d /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh ];then
    ${SCRIPT_FOLDER}/install_icc.exp
    sleep 10
fi
source /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh  intel64