#!/usr/bin/env zsh 
#   https://wiki.freebsd.org/pkgng
pkg install git
pkg install mercurial
rm /usr/local/etc/pkg.conf
mkdir -p /usr/local/etc/pkg/repos
cat << EOF >> /usr/local/etc/pkg/repos/FreeBSD.conf
FreeBSD: {
  url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest",
  mirror_type: "srv",
  enabled: yes
}
EOF
unset PACKAGESITE
pkg update


[[ -d ~/.oh-my-zsh ]] || \
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

pkg install -y wget
pkg install -y ctags
pkg install -y mercurial

# python package manager
pkg install -y py27-pip

# ag (faster than ack)
pkg install -y the_silver_searcher

cp ./rkj-repos.zsh-theme ~/.oh-my-zsh/themes

mkdir -p ~/.oh-my-zsh/custom/plugins
curl -L "https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.zip" | unzip -d ~/.oh-my-zsh/custom/plugins -
mv ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting-master ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

(cd ~ && hg clone https://bitbucket.org/sjl/hg-prompt )
(cd ~ && hg clone https://bitbucket.org/sjl/mercurial-cli-templates)

cp .gitconfig ~/
cp .vimrc ~/
cp .zshrc ~/
cp .hgrc ~/
mkdir -p ~/.vim

# git config initialize 
git config --global user.name MikimotoH
git config --global user.email mikimotoh@gmail.com
git config --global credential.helper "cache --timeout=`bc<<<3600*24*365`"
git config --global color.ui true

# Install VIM pathogen -- bundle manager
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl 'www.vim.org/scripts/download_script.php?src_id=19375' \
  > ~/.vim/autoload/pathogen.vim


if [ -f ~/.vim/colors/wombat256.vim ] ; then
    echo "wombat256.vim is already installed in vim/colors"
else 
    echo "Install wombat256 color for VIM"
    mkdir -p ~/.vim/colors && curl \
    'www.vim.org/scripts/download_script.php?src_id=13397' > ~/.vim/colors/wombat256.vim
fi

#
# install NERDTree
curl -L "https://github.com/scrooloose/nerdtree/archive/master.zip" | unzip -d ~/.vim/bundle - 
mv ~/.vim/bundle/nerdtree-master ~/.vim/bundle/nerdtree
vim ~/.vim/bundle/nerdtree/doc -c "helptags ." -c "q"

# Install Tagbar
curl -L "https://github.com/majutsushi/tagbar/archive/master.zip"|unzip -d ~/.vim/bundle -
mv ~/.vim/bundle/tagbar-master ~/.vim/bundle/tagbar
vim ~/.vim/bundle/tagbar/doc -c "helptags ." -c "q"

mkdir -p ~/.vim/plugin && \
    curl -L "www.vim.org/scripts/download_script.php?src_id=16171" > ~/.vim/plugin/DirDiff.vim

# Install AG silver searcher
curl -L "https://github.com/rking/ag.vim/archive/master.zip" | unzip -d ~/.vim/bundle -
mv ~/.vim/bundle/ag.vim-master ~/.vim/bundle/ag
vim ~/.vim/bundle/ag/doc -c "helptags ." -c "q"
echo "tags" >> ~/.agignore

if [ -d ~/.vim/doc ] ; then
    if [ "$(ls -A ~/.vim/doc )" ]; then 
        print  "~/.vim/doc not empty" 
        vim -c "helptags ~/.vim/doc/" -c "q"
    else 
        print "~/.vim/doc is empty; don't helptags" 
    fi
else
    print "make empty ~/.vim/doc/"
    mkdir -p ~/.vim/doc
fi


# cc_args.py was copied from clang_complete
mkdir -p ~/.vim/bin && \
    cp ~/bsd92env/cc_args.py ~/.vim/bin


# (cd ~/bsd92env && rm root)
