#!/bin/bash

# 项目地址
pro_path=/usr/local/puxin/hcs-system
# jar包名称
jar_name=hcs-system.jar
# 启动参数
JAVA_OPTS='-server -Xms4096m -Xmx4096m 
  -XX:NewRatio=4 -XX:SurvivorRatio=8 
  -XX:PermSize=48 -XX:MaxPermSize=64m 
  -Xss256k -XX:ThreadStackSize=128k 
  -XX:-ReduceInitialCardMarks 
  -XX:+DisableExplicitGC 
  -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled 
  -XX:ParallelCMSThreads=4 -XX:+CMSParallelRemarkEnabled 
  -XX:+UseCMSCompactAtFullCollection -XX:CMSInitiatingOccupancyFraction=50 
  -XX:CMSFullGCsBeforeCompaction=2 -XX:+UseCompressedOops -XX:+HeapDumpOnOutOfMemoryError'

cd $pro_path

# 启动jar包命令
runjar="/usr/bin/nohup /usr/local/software/jdk1.8.0_141/bin/java -jar ${JAVA_OPTS} ./${jar_name} >/dev/null 2>log &"

# 查看这个jar是否已经启动
if test $(pgrep -f $jar_name|wc -l) -eq 0
    then
    {
	# 没有启动
	echo "应用没有启动"
    }
    else
    {
	# 已经启动 清理掉
	echo "应用已经启动"
	kill -9 $(pgrep -f $jar_name)
    }
fi

# 删除原来的jar
rm -rf $pro_path/$jar_name
# 复制一份新的jar
cp /usr/local/puxin/upload/$jar_name $pro_path
#启动jar
eval $runjar
sleep 3

