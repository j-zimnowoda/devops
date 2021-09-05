# Kubernetes in Vagrant
This environment describes virtual infrastructure for simple Kubernetes cluster: master and worker nodes.

Two machines interconnected via private network (eth1: 192.168.56.0/24).

**This environment is aimed only for local and non-production usage.**

# Get started
Build kubernetes cluster (master and worked nodes) with:
```
./run.sh up
```
Inspect Vagrant file for details about underlining virtual machine configuration


Connect to master node by executing:
```
./run.sh connect
```
The default password is `welcome1` and is subject to change