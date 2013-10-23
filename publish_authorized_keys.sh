#!/bin/sh
cat ~/.ssh/id_rsa.pub | xargs ssh root@bench 'echo >>~/.ssh/authorized_keys'
