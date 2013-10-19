#!/usr/bin/env zsh
export CC=gcc
export CXX=g++
export C_INCLUDE_PATH=':/usr/include'

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
    && make ycm_core VERBOSE=1 )

mv ~/ycm_temp/llvm_root_dir/lib/libclang.so /usr/local/lib/

