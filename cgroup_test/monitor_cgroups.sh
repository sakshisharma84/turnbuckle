#!/bin/bash

rm -f con1.log
rm -f con2.log 
rm -f scon1.log
rm -f scon2.log

while true; do

con1=`cat /sys/fs/cgroup/cpuacct/cgtest/con1/cpuacct.usage_percpu`
scon1=`cat /sys/fs/cgroup/cpuacct/cgtest/con1/cpuacct.usage`

con2=`cat /sys/fs/cgroup/cpuacct/cgtest/con2/cpuacct.usage_percpu`
scon2=`cat /sys/fs/cgroup/cpuacct/cgtest/con2/cpuacct.usage`

echo "s: "$con1 | tee -a con1.log
echo "s: "$scon1 | tee -a scon1.log

echo "s: "$con2 | tee -a con2.log
echo "s: "$scon2 | tee -a scon2.log

sleep 1

done
