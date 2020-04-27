#!/bin/bash

# ~~~创建项目目录脚本~~~

# 要创建的项目
pro_arr=("engineering" "oneyn-file-system" "share-framework-gateway" "share-pmc" "share-system")

# 下面创建的所有文件夹 默认系统中不存在
lpath="$(pwd)"

# 创建一个文件夹存解压后的tomcat
mkdir $lpath/tomcat

# 解压tomcat
tar -zxvf apache-tomcat-*.tar.gz -C $lpath/tomcat
rm -rf $lpath/tomcat/apache-tomcat-*/webapps/*

# 创建app文件夹
if [ ! -d "/usr/local/app" ];then
  mkdir /usr/local/app
fi

# 创建upload文件夹
if [ ! -d "/usr/local/app/upload" ];then
  mkdir /usr/local/app/upload
fi

cd /usr/local/app

# 创建项目文件夹
for n in ${pro_arr[@]}
do
    mkdir $n
    mkdir "./$n/back"
    mkdir "./$n/bin"
    mkdir "./$n/conf"
    mkdir "./$n/logs"

    # 复制tomcat
    cp -r $lpath/tomcat/apache-tomcat-* /usr/local/app/$n

    # 复制catalina.sh到各个tomcat下的bin
    cp $lpath/jvm/catalina.sh ./$n/apache-tomcat-*/bin
    
    # 复制tomcat配置文件
    if [ -d "$lpath/config/$n" ];then
	if [ -f "$lpath/config/$n/restart-tomcat.sh" ];then
	  cp $lpath/config/$n/restart-tomcat.sh ./$n/bin
	  chmod +x ./$n/bin/restart-tomcat.sh
	fi
	if [ -f "$lpath/config/$n/server.xml" ];then
	  cp $lpath/config/$n/server.xml ./$n/apache-tomcat-*/conf
	fi
    fi

done

# 删除临时目录
rm -rf $lpath/tomcat

