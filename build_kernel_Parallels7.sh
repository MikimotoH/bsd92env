#!/usr/bin/env zsh
cp kernconf_Parallels7/GENERIC /usr/src/sys/amd64/conf/
cp kernconf_Parallels7/GENERIC.hints /usr/src/sys/amd64/conf/
cp kernconf_Parallels7/make.conf /etc/
(cd /usr/src && \
    make -j `sysctl -n kern.smp.cpus` buildkernel kernconf=GENERIC && \
    make installkernel kernconf=GENERIC)
