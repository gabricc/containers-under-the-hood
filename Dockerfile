##### Use this in case you want to extract an image using docker #####
FROM centos:latest
RUN cd /etc/yum.repos.d/ \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN dnf install python3 -y
