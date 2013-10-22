#!/usr/bin/env zsh
export CC=gcc
export CXX=g++
export C_INCLUDE_PATH=':/usr/include'

hash gcc || pkg_add -r gcc
rehash
hash gcc || export CC=$(ls /usr/local/bin/gcc* | head -n 1 )
hash g++ || export CXX=$(ls /usr/local/bin/g++* | head -n 1 )


(cd ~ \
    && pkg_add -r cmake \
    && git clone https://github.com/Valloric/YouCompleteMe.git \
    && ln -s `readlink -f ~/YouCompleteMe` ~/.vim/bundle/YouCompleteMe \
    && wget http://llvm.org/releases/3.3/clang+llvm-3.3-amd64-freebsd9.tar.xz \
    && tar zxf clang+llvm-3.3-amd64-freebsd9.tar.xz \
    && mkdir -p ~/ycm_temp/llvm_root_dir \
    && mv clang+llvm-3.3-amd64-freebsd9/* ~/ycm_temp/llvm_root_dir)

(mkdir -p ~/ycm_build \
    && cd ~/ycm_build \
    && cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/cpp \
    && make -j `sysctl -n kern.smp.cpus` ycm_core)

mv ~/ycm_temp/llvm_root_dir/lib/libclang.so /usr/local/lib/

mv ~/ycm_temp/llvm_root_dir/* ~/clang+llvm-3.3-amd64-freebsd9/

rm -rf ~/ycm_temp

rm -rf ~/ycm_build 
cp .ycm_extra_conf.py /

(cd ~/YouCompleteMe && git submodule update --init --recursive )
