#!/bin/bash

set -e
set -x

apt-get update
apt install -y build-essential wget unzip gcc-6 g++-6 unzip

wget -q --no-check-certificate https://cmake.org/files/v3.7/cmake-3.7.1-Linux-x86_64.sh -O cmake-3.7.1-Linux-x86_64.sh
chmod a+x cmake-3.7.1-Linux-x86_64.sh
./cmake-3.7.1-Linux-x86_64.sh --prefix=${BASE}/usr --skip-license
export PATH="${BASE}/usr/bin:$PATH"
export LD_LIBRARY_PATH="${BASE}/usr/lib:$LD_LIBRARY_PATH"
export CXX="g++-6" CC="gcc-6"

wget -q https://github.com/google/googletest/archive/release-1.7.0.zip -O googletest-release-1.7.0.zip
unzip -q googletest-release-1.7.0.zip
cd googletest-release-1.7.0
$CXX src/gtest-all.cc -I. -Iinclude -c
$CXX src/gtest_main.cc -I. -Iinclude -c
ar -rv libgtest.a gtest-all.o
ar -rv libgtest_main.a gtest_main.o
mkdir -p ${BASE}/usr/include
cp -r include/gtest ${BASE}/usr/include
mkdir -p ${BASE}/usr/lib
mv *.a ${BASE}/usr/lib
cd ..
