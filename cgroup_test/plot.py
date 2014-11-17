#!/usr/bin/python

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

# for automatic adjustments
from matplotlib import rcParams
rcParams.update({'figure.autolayout': True})


c1p1 = []
c1p2 = []
c1p3 = []
c1p4 = []
su1 = []

c2p1 = []
c2p2 = []
c2p3 = []
c2p4 = []
su2 = []

with open("con1.log",'r') as f:
	for line in f:
		d = line.strip().split(' ')
		if len(d) < 5:
			print "some issue with data"
		else:
			c1p1.append(int(d[1]))
			c1p2.append(int(d[2]))
			c1p3.append(int(d[3]))
			c1p4.append(int(d[4]))


with open("con2.log",'r') as f:
	for line in f:
		d = line.strip().split(' ')
		if len(d) < 5:
			print "some issue with data"
		else:
			c2p1.append(int(d[1]))
			c2p2.append(int(d[2]))
			c2p3.append(int(d[3]))
			c2p4.append(int(d[4]))

with open("scon1.log",'r') as f:
        for line in f:
                d = line.strip().split(' ')
                if len(d) < 2:
                        print "some issue with data"
                else:
                        su1.append(int(d[1]))


with open("scon2.log",'r') as f:
        for line in f:
                d = line.strip().split(' ')
                if len(d) < 2:
                        print "some issue with data"
                else:
                        su2.append(int(d[1]))


fig1, ax1 = plt.subplots()
Y1=np.arange(len(c1p1))

ax1.plot(Y1,c1p1,'k:',color='g',label="Proc 1")
ax1.plot(Y1,c1p2,'k-',color='g',label="Proc 2")
ax1.plot(Y1,c1p3,'k--',color='g',label="Proc 3")
ax1.plot(Y1,c1p4,'k_',color='g',label="Proc 4")
ax1.set_title("Container-1")
plt.ylabel('Per core CPU Usage')
plt.xlabel('Time (ms)')
legend = ax1.legend(loc='lower right')
plt.savefig("cgroup-con1.pdf")

fig2, ax2 = plt.subplots()
Y2=np.arange(len(c2p1))

ax2.plot(Y2,c2p1,'k:',color='b',label="Proc 1")
ax2.plot(Y2,c2p2,'k-',color='b',label="Proc 2")
ax2.plot(Y2,c2p3,'k--',color='b',label="Proc 3")
ax2.plot(Y2,c2p4,'k_',color='b',label="Proc 4")
ax2.set_title("Container-2")
plt.ylabel('Per core CPU Usage')
plt.xlabel('Time (ms)')
legend = ax2.legend(loc='lower right')
plt.savefig("cgroup-con2.pdf")

fig3, ax3 = plt.subplots()
Y3=np.arange(len(su1))

ax3.plot(Y3,su1,'k-',color='g',label="Container - 1")
ax3.plot(Y3,su2,'k--',color='b',label="Container - 2")
ax3.set_title("Container-2")
plt.ylabel('Total CPU Usage')
plt.xlabel('time (ms)')
legend = ax3.legend(loc='lower right')
plt.savefig("cgroup.pdf")
