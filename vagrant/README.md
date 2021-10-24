# Kubernetes in Vagrant
This environment describes virtual infrastructure for simple Kubernetes cluster of master and worker nodes.

Two virtual machines are interconnected via private network 192.168.56.0/24:

|node|user|IP address|Network interface|Vagrant init script|
|---|---|---|---|---|
|master|vagrant|192.168.56.101|eth1|`master.sh`|
|worker|vagrant|192.168.56.104|eth1|`worker.sh`|

This environment is aimed for non-production usage **only**.

# Initialize
Build kubernetes cluster (master and worked nodes) with:
```
./run.sh up
```
Inspect Vagrant file for details about underlining virtual machine configuration

# Join worker node to the cluster
In `master.log` file find `kubeadm join` phrase. Copy whole command and execute it on worker node.

# SSH to node
SSH to master node:
```
./run.sh ssh_master
```

SSH to worker node:
```
./run.sh ssh_worker
```