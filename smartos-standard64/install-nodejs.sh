#!/bin/bash
export LOG=/root/init.log
export PATH=/opt/local/gnu/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin
export NODE=v0.10.5

log( ){
  echo $1 >> $LOG
}

#House keeping
rm $LOG
rm /opt/node*

log 'Dump the environments..'
env >> $LOG
log '------------------------------'

log 'Update database...' 
pkgin update

log 'Intalling gcc ...'
pkgin -y install `pkgin se gcc | grep ^gcc | awk '{print $1}'`
pkgin -y install `pkgin search gmake | grep ^gmake | awk '{print $1}'`
pkgin -y install `pkgin se python | grep ^python | grep 2.6 | awk '{print $1}'`

log 'Downloading node.js'
cd /opt
wget http://nodejs.org/dist/$NODE/node-$NODE.tar.gz
tar -xzf node-$NODE.tar.gz

log 'Compile resources...'
mkdir /opt/bin
cd /opt/node-$NODE
/opt/node-$NODE/configure --prefix=/opt/bin/node-$NODE >> $LOG
make >> $LOG
make install >> $LOG

cd /opt
log 'Making symbolic link...'
ln -s bin/node-$NODE node

log 'Add path to bashrc'
[ ! -n "$( cat ~/.bashrc | grep node | grep PATH )" ] && echo "export PATH=/opt/node/bin:\$PATH" >> ~/.bashrc

log 'End of installer...'
