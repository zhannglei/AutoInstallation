#!/usr/bin/env bash
. ./config.sh
. ./common_fun.sh

cd ${SCRIPT_FOLDER}
check_rpm_and_install

cd ${GTEST_FOLDER}
gtest_pkg=`ls -F ${INSTALL_FOLDER} |grep gtest.*/$`
gtest_tar=`ls -F |grep gtest.*[^/]$`
if [ "${gtest_pkg}" == "" ];then
    unzip ${gtest_tar} -d ${INSTALL_FOLDER}
    gtest_pkg=`ls -F ${INSTALL_FOLDER} |grep gtest.*/$`
fi

cd ${INSTALL_FOLDER}
cd ${gtest_pkg}

./configure
cmake .
make

