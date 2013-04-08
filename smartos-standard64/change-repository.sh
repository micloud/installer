#!/bin/bash
# Author: Simon Su
# For change the repository to micloud cache site
export ORI=/opt/local/etc/pkgin/repositories.conf
export BAK=/opt/local/etc/pkgin/repositories.conf.ori
mv $ORI $BAK
sed 's/joyent.com/micloud.tw/g' $ORI > $BAK
