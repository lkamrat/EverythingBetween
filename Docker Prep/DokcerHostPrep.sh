# Change Docker Engine storage driver
tee /etc/modules-load.d/overlay.conf <<-'EOF'
overlay
EOF

reboot

tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
mkdir -p /etc/systemd/system/docker.service.d && sudo tee /etc/systemd/system/docker.service.d/override.conf <<- EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --storage-driver=overlay
EOF
yum install -y docker-engine-1.13.1 docker-engine-selinux-1.13.1
systemctl start docker
systemctl enable docker
sudo docker ps
reboot