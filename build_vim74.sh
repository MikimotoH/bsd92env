#!/usr/bin/env zsh
(cd ~ \
    && wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2 \
    && tar zxf vim-7.4.tar.bz2)
(cd ~/vim74 \
    && ./configure --with-features=huge \
            --enable-rubyinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7-config \
            --enable-perlinterp \
            --enable-luainterp \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr \
    && make -j `sysctl -n kern.smp.cpus` VIMRUNTIMEDIR=/usr/share/vim/vim74 \
    && make install 
)
[[ "$(vim --version | head -n 1 | awk '{print $5}')" == "7.4" ]] || mv `which vim` $(dirname $(which vim))/vim-old
rm -rf ~/vim74
