# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="rkj-repos"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mercurial zsh-syntax-highlighting zsh-history-substring-search )

# Customize to your needs...
export PATH='/root/sg3_utils-1.37b9r512/src:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin'
source $ZSH/oh-my-zsh.sh


#toolchain='clang'
#toolchain='gcc49'
toolchain='gcc42'

#export CPATH=
export C_INCLUDE_PATH=':/usr/include'
export CC='/usr/bin/gcc'
export CXX='/usr/bin/g++'
#export OBJC_INCLUDE_PATH
echo '===== Config toolchain Environment ====='
if [[ $toolchain == 'clang' ]]; then
    echo 'Set toolchain to Clang'
    export CC='/usr/local/bin/clang'
    export CXX='/usr/local/bin/clang++'
    export C_INCLUDE_PATH=':/usr/local/lib/clang/3.3/include'
    export CPLUS_INCLUDE_PATH=':/usr/local/include/c++/v1:/usr/local/include:/usr/include'
    export LIBRARY_PATH=':/usr/local/lib:/usr/lib'
elif [[ $toolchain == 'gcc49' ]]; then
    echo 'Set toolchain to gcc49'
    export CC='/usr/local/bin/gcc49'
    export CXX='/usr/local/bin/g++49'
    #export C_INCLUDE_PATH=:/usr/local/lib/gcc49/gcc/x86_64-portbld-freebsd9.1/4.9.0/include
    export CPLUS_INCLUDE_PATH=:/usr/local/lib/gcc49/include/c++
    #export LIBRARY_PATH=:/usr/local/lib/gcc49:/usr/local/lib/gcc49/gcc/x86_64-portbld-freebsd9.1/4.9.0:/usr/local/libexec/gcc49/gcc/x86_64-portbld-freebsd9.1/4.9.0
    #export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
    ##export PATH=/usr/libexec:$PATH
fi

#My Alias
alias gombp='ssh -p 2624 root@192.168.1.200'
alias cmsg='echo /dev/null > /var/log/messages'
alias vmsg='vim /var/log/messages'
alias tmsg='tail -f /var/log/messages'
alias l='ls -Fal'
#alias etags='exctags -R --c-kinds=+p --c-types=+p --fields=+S  --links=no --sort=foldcase .'
alias hgst='hg status'
alias hgco='hg commit -m'
alias hgup='hg update '
alias hgpu='hg pull'
alias hgps='hg push'
alias hgdi='hg diff -bBw'
alias hgsg='hg sglog|head -43'
alias md='mkdir -p'
alias find_largest_dir='du -sx * |sort  -k1 -n -r|head'
# 57=ETTodayMoney
# mercurial=131
# bench=95, kitty=45
# miki-bsd9=200, mbp=143
# reef=124,toaster=21
# pt-12k=147, hp1=130, rb=99
# -f is background, -N is do NOT execute remote command
alias gopizza='ssh -L localhost:57131:192.168.1.131:22 -L localhost:57095:192.168.1.95:22 -L localhost:57045:192.168.1.45:22 -L localhost:57200:192.168.1.200:22 -L          localhost:57143:192.168.1.143:22 -L localhost:57124:192.168.1.124:22 -L localhost:57021:192.168.1.21:22 -L localhost:57147:192.168.1.147:22 -L localhost:57130:192.168.1.130:22 -L localhost:57099:192.168.1.99:22 picoral@picoral.dyns.cx'

alias daemonlist='ps -lA | awk '"'"'$12 == "?" {print $4, $14} '"'"''
export TERM=xterm-256color
export PACKAGESITE=http://freebsd.ntu.edu.tw/FreeBSD/ports/amd64/packages-9.2-release/Latest/
export EDITOR=/usr/local/bin/vim
export MYVIMRC=/root/.vimrc
export VIM=/usr/local/share/vim/vim74
export VIMRUNTIME=/usr/local/share/vim/vim74
setopt extendedglob
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Use VIM as man page viewer
# http://ebergen.net/wordpress/2009/06/04/using-vim-as-a-man-page-viewer/
export EDITOR=vim
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
