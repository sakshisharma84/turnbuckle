docker_set_get
==============

What is docket_set_get ?
------------------------
It is a docker patch to support two additional client commands:

1. stats (get): To get system level stats about resources utilized by a native  container running on docker.

2. set : To set/modify allocated system resources allocated to container at runtime.

What is currenty supported ?
----------------------------

Get Command: 

*_Usage: docker stats [container-id]_*

Example Usage/Output:

```bash

~/docker$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
e54efeb51eb8        ubuntu:14.04        "/bin/sh -c 'while t   5 minutes ago       Up 5 minutes                            clever_shockley    
1105763b7e03        ubuntu:14.04        "/bin/sh -c 'while t   6 minutes ago       Up 6 minutes                            condescending_tesla

~/docker$ sudo docker stats clever_shockley

Docker Stats
CPU:
Total usage: 327356401
Kernelmode usage: 260000000
UserMode usage: 80000000

Memory:
Current usage: 221184
Maximum usage: 1421312
Fail Count: 0

~/docker$ sudo docker stats condescending_tesla     

Docker Stats
CPU:
Total usage: 392069004
Kernelmode usage: 300000000
UserMode usage: 120000000
Memory:
Current usage: 225280
Maximum usage: 1052672
Fail Count: 0
``` 
 

Set Command:
	
*_Usage: docker set [container-id] resource=value_*

This patch currently supports modification of cpushares only. This can be further extended by adding support for other parameters like cfs-quota-us

Example Usage/Output:

```bash

~/docker$ sudo docker ps

CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
90c85dde05d7        ubuntu:14.04        "/bin/sh -c 'while t   11 seconds ago      Up 10 seconds                           silly_hawking

~/docker$ cat /sys/fs/cgroup/cpu/docker/90c85dde05d72c4c615dadf2a6e3da814d676435ee31c12969df7475ee04c449/cpu.shares
1024
~/docker$ sudo docker set silly_hawking cpushares=512
hey! entering In CmdSet....
CmdSet:: name is silly_hawking
CmdSet:: PARAM is cpushares
CmdSet:: VAL is 512
CmdSet:: SET SUCCESSFULLY!!
~/docker$
~/docker$ cat /sys/fs/cgroup/cpu/docker/90c85dde05d72c4c615dadf2a6e3da814d676435ee31c12969df7475ee04c449/cpu.shares
512
~/docker$
```

How to use this patch ?
-----------------------
TODO

Limitations/Issues
------------------

For more details: Sakshi Sharma (ssharma311@gatech.edu)
