#!/bin/bash
mkdir ~/.ssh
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin .*/PermitRootLogin without-password/' /etc/ssh/sshd_config
cp ~/.ssh/id_rsa /tmp/
yum remove dnsmasq -y
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
rpm -ivh epel-release-7-9.noarch.rpm
yum --enablerepo=epel -y install sshpass
cat ~/.ssh/id_rsa.pub | ssh root@xLab-DCOS-Private-Agent-03 "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"
sshpass -p "Bimba1$$" ssh root@xLab-DCOS-Master-02
sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin .*/PermitRootLogin without-password/' /etc/ssh/sshd_config
reboot

# 
systemctl stop firewalld
systemctl disable firewalld
ssh root@xLab-DCOS-Master-02
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux && cat /etc/sysconfig/selinux
groupadd nogroup
reboot

1) Edit /etc/default/grub
2) Add selinux=0 to GRUB_CMDLINE_LINUX
3) grub2-mkconfig -o /boot/grub2/grub.cfg
4) reboot and selinux is disabled



wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
rpm -ivh epel-release-7-9.noarch.rpm
yum --enablerepo=epel -y install sshpass
sshpass -p "Bimba1$$" ssh root@xLab-DCOS-Master-02
#yum remove dnsmasq -y
#reboot