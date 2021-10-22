#!/bin/bash
#/* **************** LFS260:2021-03-05 s_04/k8sMaster.sh **************** */
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
## TxS 1-2021 
## v1.20.1 CKA/CKAD/CKS
echo "This script is written to work with Ubuntu 18.04"
sleep 3
echo
echo "Disable swap until next reboot"
echo 
sudo swapoff -a

readonly user=student
# Make user with password welcome1
useradd $user -m -p '$6$UhZjFYH1$9RiEbku8QFfIiKq0mf5spCHABaAK218nbH/c3ISzc63v5VRmM/2aUSRpsq3IAJ025.yXbOSJPCpr.VsgG.g3o.' -s /bin/bash
printf "$user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
chmod 440 /etc/sudoers.d/$user

echo "Update the local node"
sudo apt-get update && sudo apt-get upgrade -y
echo
echo "Install Docker"
sleep 3
sudo apt-get install -y docker.io
echo
echo "Install kubeadm, kubelet, and kubectl"
sleep 3

echo 'KUBELET_EXTRA_ARGS="--node-ip=192.168.56.101"' >  /etc/default/kubelet

sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"

sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"

# Fix for GPG error: https://packages.cloud.google.com/apt kubernetes-xenial 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FEEA9169307EA071
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B57C5C2836F4BEB

sudo apt-get update


sudo apt-get install -y kubeadm=1.20.1-00 kubelet=1.20.1-00 kubectl=1.20.1-00

sudo apt-mark hold kubelet kubeadm kubectl

echo
echo "Installed - now to get Calico Project network plugin"

## If you are going to use a different plugin you'll want
## to use a different IP address, found in that plugins 
## readme file. 

sleep 3

sudo kubeadm init \
--kubernetes-version 1.20.1 \
--pod-network-cidr 10.244.0.0/16 \
--apiserver-advertise-address=192.168.56.101

sleep 5

echo "Running the steps explained at the end of the init output for you"

mkdir -p $HOME/.kube

sleep 2

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sleep 2

sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Apply Calico network plugin from ProjectCalico.org"
echo "If you see an error they may have updated the yaml file"
echo "Use a browser, navigate to the site and find the updated file"

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo
echo
sleep 3
echo "You should see this node in the output below"
echo "It can take up to a minute for node to show Ready status"
echo
kubectl get node
echo

mkdir -p /home/$user/.ssh
chown $user: /home/$user/.ssh
mkdir -p /home/$user/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/$user/.kube/config
sudo chown -R $user: /home/$user/.kube/config

sleep 2

echo
echo "Script finished. Move to the next step"
