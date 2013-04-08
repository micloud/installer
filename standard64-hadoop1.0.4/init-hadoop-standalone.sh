export HADOOP=/usr/local/hadoop
export SSH_HOME=~/.ssh

echo "Clean config files ..."
cat - > $HADOOP/conf/core-site.xml <<EOF
<configuration></configuration>
EOF

cat - > $HADOOP/conf/hdfs-site.xml <<EOF
<configuration></configuration>
EOF

cat - > $HADOOP/conf/mapred-site.xml <<EOF
<configuration></configuration>
EOF

echo "Clean output..."
rm -rf $HADOOP/output


echo "Edit .bashrc ..."
cat - > /tmp/bashrc.tmp <<EOF
export JAVA_HOME=/opt/local/java/sun6
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=$JAVA_HOME/lib/tools.jar:.
EOF
[ ! -n "$( cat ~/.bashrc | grep JAVA_HOME | grep java )" ] && cat /tmp/bashrc.tmp >> ~/.bashrc


echo "===============Standalone Operation==============="
cd $HADOOP
rm -rf input
mkdir input 
cp conf/*.xml input 
bin/hadoop jar hadoop-examples-*.jar grep input output 'dfs[a-z.]+' 
cat output/*

