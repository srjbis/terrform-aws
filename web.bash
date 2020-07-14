#!/bin/bash 
sudo touch /home/ec2-user/user-data.log
echo "########## DISABLE THE SELINUX #####################" >> /home/ec2-user/user-data.log
sudo setenforce 0 >> /home/ec2-user/user-data.log
sudo sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux >> /home/ec2-user/user-data.log
sudo yum update -y >> /home/ec2-user/user-data.log
sudo yum install git -y >> /home/ec2-user/user-data.log
sudo yum install -y nfs-utils >> /home/ec2-user/user-data.log
sudo mkdir -p /opt/mount >> /home/ec2-user/user-data.log
#sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-91436812.efs.us-east-1.amazonaws.com:/ /opt/mount >> /home/ec2-user/user-data.log
echo "############  INSTALLING DOCKER DEPENDENCIES YUM, DEVICE-MAPPER AND LVM2 ###################" >> /home/ec2-user/user-data.log
sudo yum install -y yum-utils device-mapper-persistent-data lvm2 >> /home/ec2-user/user-data.log
echo "########### ADDING DOCKER REPO ################" >> /home/ec2-user/user-data.log
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo >> /home/ec2-user/user-data.log
echo "#################### ENABLING THE DOCKER-CE-NIGHTLY ################" >> /home/ec2-user/user-data.log
sudo yum-config-manager --enable docker-ce-nightly >> /home/ec2-user/user-data.log
echo "################## INSTALLING containerd.io-1.2.6 ######" >> /home/ec2-user/user-data.log
yum -y install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm >> /home/ec2-user/user-data.log
echo "########### INSTALLING DOCKER ########################" >> /home/ec2-user/user-data.log
sudo yum install -y docker-ce docker-ce-cli >> /home/ec2-user/user-data.log
echo "############# STARTING THE DOCKER ################" >> /home/ec2-user/user-data.log
sudo systemctl restart docker >> /home/ec2-user/user-data.log
sudo systemctl enable docker >> /home/ec2-user/user-data.log
sudo docker pull tomcat
sudo docker run -d -p 8080:8080 tomcat
