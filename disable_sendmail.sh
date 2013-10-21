#!/bin/sh
# http://forums.freebsd.org/showthread.php?t=25765

cat << EOF >> /etc/rc.conf
sendmail_msp_queue_enable="NO"
sendmail_outbound_enable="NO"
sendmail_submit_enable="NO"
NO_SENDMAIL=true
EOF

/etc/rc.d/sendmail onestop
