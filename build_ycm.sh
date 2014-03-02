#!/usr/bin/env zsh
export CC=gcc
export CXX=g++
export C_INCLUDE_PATH=':/usr/include'


hash gcc || pkg install  -y gcc
rehash
# Assert gcc version > 4.6
mv /usr/bin/gcc /usr/bin/gcc42
mv /usr/bin/g++ /usr/bin/g++42
ln -s /usr/local/bin/gcc46 /usr/bin/gcc
ln -s /usr/local/bin/g++46 /usr/bin/g++

pkg install cmake

git clone https://github.com/Valloric/YouCompleteMe.git ~/YouCompleteMe
ln -s `readlink -f ~/YouCompleteMe` ~/.vim/bundle/YouCompleteMe
wget http://llvm.org/releases/3.4/clang+llvm-3.4-amd64-unknown-freebsd9.2.tar.xz
tar xvf clang+llvm-3.4-amd64-unknown-freebsd9.2.tar.xz
mkdir -p ~/ycm_temp
ln -s /root/clang+llvm-3.4-amd64-unknown-freebsd9.2 ~/ycm_temp/llvm_root_dir

mv /usr/lib/libstdc++.so.6 /usr/lib/stdc++.so.6-GLIBCXX_3.2
ln -s /usr/local/lib/gcc46/libstdc++.so.6 /usr/lib/libstdc++.so.6


mkdir -p ~/ycm_build
cd ~/ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/cpp
cpus=`sysctl -n kern.smp.cpus` 
make -j8 VERBOSE=1 LDFLAGS="-L/usr/local/lib/gcc46" ycm_support_libs

cp ~/ycm_temp/llvm_root_dir/lib/libclang.so /usr/local/lib/

cp .ycm_extra_conf.py /

(cd ~/YouCompleteMe && git submodule update --init --recursive )
