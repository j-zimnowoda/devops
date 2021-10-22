#!/bin/bash
#/* **************** LFS260:2021-03-05 s_04/k8sSecond.sh **************** */
#/*
# * The code herein is: Copyright the Linux Foundation, 2021
# *
# * This Copyright is retained for the purpose of protecting free
# * redistribution of source.
# *
# *     URL:    https://training.linuxfoundation.org
# *     email:  info@linuxfoundation.org
# *
# * This code is distributed under Version 2 of the GNU General Public
# * License, which you should have received with the source.
# *
# */
#!/bin/bash -x
## TxS 01-2021
## CKA/CKAD/CKS for 1.20.1
##

echo "  This script is written to work with Ubuntu 18.04"
echo
sleep 3
echo "  Disable swap until next reboot"
echo
sudo swapoff -a

# Make a student sudo user with password welcome1
useradd student -m -p '$6$UhZjFYH1$9RiEbku8QFfIiKq0mf5spCHABaAK218nbH/c3ISzc63v5VRmM/2aUSRpsq3IAJ025.yXbOSJPCpr.VsgG.g3o.' -s /bin/bash
mkdir -p /home/student/.ssh
printf 'student ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/student
chmod 440 /etc/sudoers.d/student

echo "  Update the local node"
sleep 2
sudo apt-get update && sudo apt-get upgrade -y
echo
sleep 2

echo "  Install Docker"
sleep 3
sudo apt-get install -y docker.io

echo 'KUBELET_EXTRA_ARGS="--node-ip=192.168.56.104"' > /etc/default/kubelet

echo
echo "  Install kubeadm, kubelet, and kubectl"
# Fix for GPG error: https://packages.cloud.google.com/apt kubernetes-xenial 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FEEA9169307EA071
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B57C5C2836F4BEB
sleep 2

sleep 2
sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"

sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"

sudo apt-get update

sudo apt-get install -y kubeadm=1.20.1-00 kubelet=1.20.1-00 kubectl=1.20.1-00

sudo apt-mark hold kubelet kubeadm kubectl
echo
echo "  Script finished. You now need the kubeadm join command"
echo "  from the output on the master node"
echo 

