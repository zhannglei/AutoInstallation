#!/usr/bin/env bash

#folder
cd $(dirname ${BASH_SOURCE[0]})
export BASE_FOLDER=${PWD}
export SCRIPT_TAR_FOLDER=${BASE_FOLDER}/Configs/Preinstall_script
export SCRIPT_FOLDER=${BASE_FOLDER}/Configs/Preinstall_script/Auto_Installation
export TMOUT=86400

cd ${SCRIPT_TAR_FOLDER}

[ -d ${SCRIPT_FOLDER} ] || tar -xf *.tar
cd ${SCRIPT_FOLDER}
. ./run.sh
