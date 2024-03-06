#!/usr/bin/bash
vaspkit <<< 11 <<< 111

vaspkit << EOF
11
115
1-8
all
9-16
all
17-24
all
25-56
all

EOF

pdos_CFO_bulk.py


