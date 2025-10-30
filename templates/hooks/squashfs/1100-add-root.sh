#!/bin/sh


mkdir /root -p 

cat >/etc/passwd <<EOF
root::0:0:root:/root:/bin/sh
EOF

touch /etc/shadow

