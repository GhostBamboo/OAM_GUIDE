#!/bin/bash

# ~~~配置jdk脚本~~~

# 如果没有software文件夹就创建
if [ ! -d "/usr/local/software" ];then
  mkdir /usr/local/software
fi

# 解压jdk到software文件夹
tar -zxvf jdk-*.tar.gz -C /usr/local/software
cd /usr/local/software/jdk*

# jdk路径
jdkpath=$(pwd)

# 配置环境变量
echo "export JAVA_HOME=$jdkpath" >> /etc/profile
echo 'export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar' >> /etc/profile
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile

# 好像没有用  走完脚本后 手动执行一下
source /etc/profile

