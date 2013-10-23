#!/usr/bin/env zsh
rmb=root@bsd92host
scp -C $rmb:/usr/sbin/pkg_add /usr/sbin/pkg_add
scp -C $rmb:/usr/sbin/pkg_info /usr/sbin/pkg_info

mkdir -p /usr/local/lib/perl5/5.14/mach/CORE
for i in /usr/local/bin/vim /lib/libm.so.5 /lib/libncurses.so.8 /usr/local/lib/libiconv.so.3 /usr/local/lib/libintl.so.9 /usr/local/lib/perl5/5.14/mach/CORE/libperl.so /usr/local/lib/libpython2.7.so /usr/local/lib/libtcl86.so.1 /lib/libthr.so.3 /usr/local/lib/libruby19.so.19  /lib/libc.so.7 /lib/libcrypt.so.5 /lib/libutil.so.9 /lib/libz.so.6 /usr/local/lib/libexecinfo.so.1 ; do scp -C $rmb:$i $i ; done

scp -Cr $rmb:/usr/local/lib/python2.7 /usr/local/lib
mkdir -p /usr/share/vim/vim74
scp -Cr $rmb:/usr/share/vim/vim74 /usr/share/vim
scp /usr/share/vim/vim74/syntax/syntax.vim
ln -sf /usr/share/vim/vim74 /usr/local/share/vim/vim74
ln -sf ~/.vim/bundle/YouCompleteMe/python/libclang.so /usr/local/lib/libclang.so
scp -C $rmb:/usr/local/lib/libc++.so.1 /usr/local/lib/libc++.so.1
scp -Cr $rmb:~/.vim ~/
scp -C $rmb:~/.vimrc ~/
scp -C $rmb:~/.ycm_extra_conf.py ~/

# hg
scp -C $rmb:~/.hgrc ~/
scp -Cr $rmb:~/hg-prompt ~/
scp -Cr $rmb:~/mercurial-cli-templates ~/
# zsh
scp -C $rmb:~/.zshrc ~/
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
scp -C $rmb:~/.oh-my-zsh/themes/rkj-repos.zsh-theme ~/.oh-my-zsh/themes/rkj-repos.zsh-theme

# vim utilities
scp -C $rmb:/usr/local/bin/exctags /usr/local/bin/exctags
scp -C $rmb:/usr/local/bin/ack /usr/local/bin/ack
echo "finished"
