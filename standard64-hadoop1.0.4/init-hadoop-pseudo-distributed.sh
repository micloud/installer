export HADOOP=/usr/local/hadoop
export SSH_HOME=~/.ssh


echo "===============Pseudo-Distributed Operation==============="
cd $HADOOP
rm -rf input
mkdir input 
cp conf/*.xml input

echo "Create config files ..."
cat - > $HADOOP/conf/core-site.xml <<EOF
<configuration>
     <property>
         <name>fs.default.name</name>
         <value>hdfs://localhost:9000</value>
     </property>
</configuration>
EOF

cat - > $HADOOP/conf/hdfs-site.xml <<EOF
<configuration>
     <property>
         <name>dfs.replication</name>
         <value>1</value>
     </property>
</configuration>
EOF

cat - > $HADOOP/conf/mapred-site.xml <<EOF
<configuration>
     <property>
         <name>mapred.job.tracker</name>
         <value>localhost:9001</value>
     </property>
</configuration>
EOF

echo "Edit .bashrc ..."
cat - > /tmp/bashrc.tmp <<EOF
export JAVA_HOME=/opt/local/java/sun6
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=$JAVA_HOME/lib/tools.jar:.
EOF
[ ! -n "$( cat ~/.bashrc | grep JAVA_HOME | grep java )" ] && cat /tmp/bashrc.tmp >> ~/.bashrc

. ~/.bashrc

echo "===============Setup passphraseless ssh==============="
echo "Start to sync ssh key to local..."
rm $SSH_HOME/id_rsa
ssh-keygen -q -t rsa -f $SSH_HOME/id_rsa -P '' 
cat $SSH_HOME/id_rsa.pub >> $SSH_HOME/authorized_keys

echo "===============Execution==============="
cd $HADOOP
echo "Y" | bin/hadoop namenode -format
bin/start-all.sh

