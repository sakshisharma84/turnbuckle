#!/bin/bash

killall python
rm -rf /sys/fs/cgroup/cpu/cgtest/con1
rm -rf /sys/fs/cgroup/cpu/cgtest/con2
rm -rf /sys/fs/cgroup/cpuacct/cgtest/con1
rm -rf /sys/fs/cgroup/cpuacct/cgtest/con2
