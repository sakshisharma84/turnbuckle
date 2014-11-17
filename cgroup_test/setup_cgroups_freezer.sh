#!/bin/bash

mkdir -p /sys/fs/cgroup/cpu/cgtest

mkdir -p /sys/fs/cgroup/cpu/cgtest/con1
mkdir -p /sys/fs/cgroup/cpuacct/cgtest/con1
mkdir -p /sys/fs/cgroup/freezer/cgtest/con1

mkdir -p /sys/fs/cgroup/cpu/cgtest/con2
mkdir -p /sys/fs/cgroup/cpuacct/cgtest/con2
mkdir -p /sys/fs/cgroup/freezer/cgtest/con2

echo "Current CPU share: con1"
/bin/echo 1024 > /sys/fs/cgroup/cpu/cgtest/con1/cpu.shares
cat /sys/fs/cgroup/cpu/cgtest/con1/cpu.shares

echo "Current CPU share: con2"
/bin/echo 1024 > /sys/fs/cgroup/cpu/cgtest/con2/cpu.shares
cat /sys/fs/cgroup/cpu/cgtest/con2/cpu.shares

echo "Throttling CPU ..."
python cgclient.py cpu &  
clpid1=$!

/bin/echo $clpid1 > /sys/fs/cgroup/cpu/cgtest/con1/tasks
/bin/echo $clpid1 > /sys/fs/cgroup/cpuacct/cgtest/con1/tasks
 
python cgclient.py cpu &  
clpid2=$!


echo "Waiting to start ..."
sleep 10

echo "Adding tasks to cgroup ..."
/bin/echo $clpid2 > /sys/fs/cgroup/cpu/cgtest/con2/tasks
/bin/echo $clpid2 > /sys/fs/cgroup/cpuacct/cgtest/con2/tasks

echo "Start monitoring ..."
./monitor_cgroups.sh &
mnpid=$!

sleep 60

# freeze the container
echo "Current Freezer state ... "
cat /sys/fs/cgroup/freezer/cgtest/con2/freezer.state
/bin/echo FROZEN > /sys/fs/cgroup/freezer/cgtest/con2/freezer.state
echo "New Freezer state ... "
cat /sys/fs/cgroup/freezer/cgtest/con2/freezer.state

echo "Changing cpu share con2 ..."
/bin/echo 512 > /sys/fs/cgroup/cpu/cgtest/con2/cpu.shares
echo "New CPU share con2 : "
cat /sys/fs/cgroup/cpu/cgtest/con2/cpu.shares

# Thae the contianer
echo "Current Freezer state ... "
cat /sys/fs/cgroup/freezer/cgtest/con2/freezer.state
/bin/echo THAWED > /sys/fs/cgroup/freezer/cgtest/con2/freezer.state
echo "New Freezer state ... "
cat /sys/fs/cgroup/freezer/cgtest/con2/freezer.state

sleep 60

kill $mnpid
./cleanup.sh

python plot.py

echo "Plotted CPU usage of two containers."
