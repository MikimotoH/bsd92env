#!/usr/bin/env zsh
hash exctags || pkg_add -r ctags
rehash
hash exctags || echo "no exctags installed"

#/usr/src/sys
#/usr/src/sys/amd64/include
#/usr/src/sys/x86/include
#/usr/src/sys/contrib/altq 

(cd /usr/src/sys && \
    exctags -R --c-kinds=+p  --links=no --sort=foldcase --exclude=arm --exclude=ia64 --exclude=pc98 --exclude=mips --exclude=i386 --exclude=powerpc --exclude=sparc64 --exclude=netinet6 --exclude=netsmb --exclude=netgraph --exclude=net80211 --exclude=netncp --exclude=xen --exclude=ofed --exclude=security --exclude=dev --exclude=kgssapi --exclude=geom --exclude=gdb --exclude=netatalk --exclude=nfs --exclude=nlm .)

