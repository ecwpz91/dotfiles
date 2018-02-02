yum-update() {
 sudo bash -c 'yum clean all
               rm -rf /var/cache/yum/*
               yum makecache fast
               yum update -y
               yum autoremove -y
 '
}
