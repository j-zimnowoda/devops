# Kubernetes in Vagrant
This environment describes virtual infrastructure for simple Kubernetes cluster: master and worker nodes.

Two virtual machines interconnected via private network:

|node|user|IP address|Network interface|Vagrant init script|
|---|---|---|---|---|
|master|student|192.168.56.101|eth1|master.sh|
|worker|student|192.168.56.104|eth1|worker.sh|

This environment is aimed **only** for experimental usage.

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

