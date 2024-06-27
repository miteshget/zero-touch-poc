dnf clean all
#Install a package to build metadata of the repo and not need to wait during labs
dnf install -y cups-filesystem
systemctl stop nginx
setenforce 0
