#!/usr/bin/env bash
. ./config.sh

[ ! -d ${INSTALL_FOLDER} ] && mkdir ${INSTALL_FOLDER}
cd ${GTEST_FOLDER}
gtest_pkg=`ls -F ${INSTALL_FOLDER} |grep gtest.*/$`
gtest_tar=`ls -F |grep gtest.*[^/]$`
if [ "${gtest_pkg}" == "" ];then
    unzip ${gtest_tar} -d ${INSTALL_FOLDER}
    gtest_pkg=`ls -F ${INSTALL_FOLDER} |grep gtest.*/$`
fi

cd ${INSTALL_FOLDER}
cd ${gtest_pkg}

if [ -f CMakeFiles/gtest.dir/src/gtest-all.cc.o ];then
    echo "gtest has already installed."
else
    ./configure
    cmake .
    make
    if [ -f CMakeFiles/gtest.dir/src/gtest-all.cc.o ];then
        echo "gtest is installed successfully."
    else
        echo "gtest is installed failed."
        exit 1
    fi
fi

