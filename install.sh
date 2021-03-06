#!/usr/bin/env zsh 
# pre-requirement:
#   oh-my-zsh, vim 7.3(+python ) and clang installed

setenv PACKAGESITE http://freebsd.ntu.edu.tw/FreeBSD/ports/amd64/packages-9.2-release/Latest/
export PACKAGESITE=http://freebsd.ntu.edu.tw/FreeBSD/ports/amd64/packages-9.2-release/Latest/
[ -d ~/.oh-my-zsh ] || \
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

pkg_add -r vim
pkg_add -r wget
pkg_add -r mercurial
# python package manager
pkg_add -r py27-pip

# ag (faster than ack)
pkg_add -r the_silver_searcher
pkg_add -r ack


cp ./rkj-repos.zsh-theme ~/.oh-my-zsh/themes

mkdir -p ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search

hg clone https://bitbucket.org/sjl/hg-prompt ~/hg-prompt
hg clone https://bitbucket.org/sjl/mercurial-cli-templates ~/mercurial-cli-templates

ln -sf `readlink -f .gitconfig` ~/
ln -sf `readlink -f .vimrc` ~/
ln -sf `readlink -f .zshrc` ~/
ln -sf `readlink -f .hgrc`  ~/
mkdir -p ~/.vim

# git config initialize 
git config --global user.name MikimotoH
git config --global user.email mikimotoh@gmail.com
git config --global credential.helper "cache --timeout=`bc<<<3600*24*365`"
git config --global color.ui true

# Install VIM pathogen -- bundle manager
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl 'www.vim.org/scripts/download_script.php?src_id=19375' > ~/.vim/autoload/pathogen.vim


mkdir -p ~/.vim/colors && curl 'www.vim.org/scripts/download_script.php?src_id=13397' > ~/.vim/colors/wombat256.vim

git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

git clone git://github.com/majutsushi/tagbar ~/.vim/bundle/tagbar


mkdir -p ~/.vim/plugin && \
    curl -L "www.vim.org/scripts/download_script.php?src_id=16171" > ~/.vim/plugin/DirDiff.vim

# install Ag
git clone https://github.com/rking/ag.vim ~/.vim/bundle/ag &&\
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

[[ -d /usr/local/share/vim/vim74 ]] || ln -s /usr/local/share/vim/vim73 /usr/local/share/vim/vim74


vim -c "helptags ~/.vim/bundle/nerdtree/doc/" -c "helptags ~/.vim/bundle/tagbar/doc/" -c q

# cc_args.py was copied from clang_complete
mkdir -p ~/.vim/bin && \
    cp ~/bsd92env/cc_args.py ~/.vim/bin


rm -f ~/bsd92env/root

