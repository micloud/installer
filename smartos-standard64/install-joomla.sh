#!/bin/bash
export PATH=/opt/local/gnu/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin
export SRC=/opt/src
export JOOMLA_FILE=Joomla_2.5.4-Stable-Full_Package.zip
export URL=http://www.openfoundry.org/of/download_path/joomla/2.5.x
export DEPLOY=/opt/local/share/httpd/htdocs
[ ! -e $SRC ] && mkdir $SRC
[ ! -e $SRC/joomla ] && mkdir $SRC/joomla

echo 'Installing unzip...'
pkgin -y install `pkgin search unzip | grep ^unzip | awk '{print $1}'`

echo 'Downloading joomla...'
cd $SRC/joomla/
echo Current PATH:`pwd`
wget $URL/$JOOMLA_FILE

echo 'Unzip joomla'
cd $SRC/joomla/
echo Current PATH:`pwd`
unzip $JOOMLA_FILE
rm -rf $JOOMLA_FILE

echo 'Install to apache...'
cd $SRC
echo Current PATH:`pwd`
mv -f $SRC/joomla/* $DEPLOY

echo 'Clean tmp files...'
rm -rf $SRC/joomla

echo 'Apache server restart...'
svcadm disable apache
svcadm enable apache
