yum-update() {
 printf "%s " "root@${HOSTNAME}"; su - root -c 'yum clean all
                                                rm -rf /var/cache/yum/*
                                                yum makecache fast
                                                yum update -y
                                                yum autoremove -y
 '
}
