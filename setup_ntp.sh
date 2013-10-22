#!/bin/sh
# http://www.freebsd.org/doc/handbook/network-ntp.html
# see /usr/share/examples/etc/ntp.conf  for example
# The option `iburst' is used for faster initial synchronisation.

cat << EOF > /etc/ntp.conf
server 0.tw.pool.ntp.org prefer
server 1.tw.pool.ntp.org
server 2.tw.pool.ntp.org
server 3.tw.pool.ntp.org
EOF
service ntpd stop
ntpdate 0.tw.pool.ntp.org
service ntpd restart

# don't forget to 
# cat ntpd_enable="YES" >> /etc/rc.conf
