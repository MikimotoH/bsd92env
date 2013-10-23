#!/usr/bin/env zsh
cp kernconf_fusion5/GENERIC /usr/src/sys/amd64/conf/
cp kernconf_fusion5/GENERIC.hints /usr/src/sys/amd64/conf/
cp kernconf_fusion5/make.conf /etc/
cp kernconf_fusion5/sysctl.conf /etc/
(cd /usr/src && \
    make -j `sysctl -n kern.smp.cpus` buildkernel kernconf=GENERIC && \
    make installkernel kernconf=GENERIC)
