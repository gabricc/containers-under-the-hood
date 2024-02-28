#!/bin/bash

## Install required packages
echo -e "\n" | add-apt-repository universe
apt update; apt install cgroup-tools debootstrap stress lynx cg-tools -y

## Download debian image
debootstrap stable ./debian http://deb.debian.org/debian/

## Switch from CGroup v2 to v1 (required to overcome this error: "cgroups can't be listed: Cgroup is not mounted")
cp /etc/default/grub /etc/default/grub_bkp
sed -i '/^GRUB_CMDLINE_LINUX/ s/"$/ systemd.unified_cgroup_hierarchy=0"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

##### Use this in case you want to extract an image using docker #####

## Add Docker's official GPG key:
#sudo apt-get update
#sudo apt-get install ca-certificates curl
#sudo install -m 0755 -d /etc/apt/keyrings
#sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
#sudo chmod a+r /etc/apt/keyrings/docker.asc
#
## Add the repository to Apt sources:
#echo \
#  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
#  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
#  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo apt-get update
#
## Install docker packages
#sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
#
## Install lynx
#sudo apt install lynx -y
#
#cat << EOF >> Dockerfile
#FROM centos:latest
#RUN cd /etc/yum.repos.d/
#RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
#    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
#RUN dnf install python3 -y
#EOF
#
#docker build -t centos-local:latest .
#
### Extracting image from docker
#docker run --name imagem centos:latest
#docker export imagem > centos.tar
#
#sudo mkdir /mnt/{image,upper,work,merged}
#sudo tar -xvf centos.tar -C /mnt/image/
#
### Stop docker
#sudo systemctl stop docker
