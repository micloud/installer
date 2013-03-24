#!/bin/bash
export LOG=/root/init.log
export PATH=/opt/local/gnu/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin

log( ){
  echo $1 >> $LOG
}

rm $LOG
rm /opt/node*

env >> $LOG

log 'Update database...' 
pkgin update

log 'Intalling gcc ...'
pkgin -y install `pkgin se gcc | grep ^gcc | awk '{print $1}'`
pkgin -y install `pkgin search gmake | grep ^gmake | awk '{print $1}'`
pkgin -y install `pkgin se python | grep ^python | grep 2.6 | awk '{print $1}'`

log 'Downloading node.js'
cd /opt
wget http://nodejs.org/dist/v0.10.1/node-v0.10.1.tar.gz
tar -xzf node-v0.10.1.tar.gz

log 'Compile resources...'
cd /opt/node-v0.10.1
mkdir /opt/bin
/opt/bin
cd /opt/node-v0.10.1/configure --prefix=/opt/bin/node-v0.10.1 && make && make install

cd /opt
log 'Making symbolic link...'
ln -s bin/node-v0.10.1 node
