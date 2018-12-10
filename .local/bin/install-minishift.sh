install-minishift() {
 sudo /bin/bash -c 'yum -y install libvirt qemu-kvm

                    usermod -a -G libvirt $USER

                    # Install docker-machine
                    curl -L https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-`uname -s`-`uname -m` \
                         -o /usr/local/bin/docker-machine \
                    && chmod +x /usr/local/bin/docker-machine

                    # Install the KVM binary driver
                    curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 \
                         -o /usr/local/bin/docker-machine-driver-kvm \
                    && chmod +x /usr/local/bin/docker-machine-driver-kvm
 '

 # [TODO] Automate login and download from Red Hat customer portal via
 # https://access.redhat.com/downloads/content/293/ver=3.3/rhel---7/3.3/x86_64/product-software
 #
 # Get content delivery network server cookies
 # wget --save-cookies cookies.txt \
  #      --keep-session-cookies \
  #      --post-data "user=${MINISHIFT_USERNAME}&passwrd=${MINISHIFT_PASSWORD}" \
  #      --delete-after \
  #      - 'https://sso.jboss.org/login'
 #
 # Setup binary from JBoss Deverlopers website
 # sudo wget --load-cookies cookies.txt \
  #      https://developers.redhat.com/download-manager/file/cdk-3.0.beta-minishift-linux-amd64 -O /usr/bin/minishift

 # Install Minishift binary
 mv ~/Downloads/cdk-3.3.0-1-minishift* ~/.local/bin/minishift

 # Configure Minishift
 minishift config set cpus 2
 minishift config set memory 4096

 printf "%s\n" "export MINISHIFT_USERNAME=${MINISHIFT_USERNAME:-}" >> ~/.bashrc  # Red Hat Subscription Manager (RHSM) username
 printf "%s\n" "export MINISHIFT_PASSWORD=${MINISHIFT_PASSWORD:-}" >> ~/.bashrc  # RHSM password

 # Install bash completion
 # minishift completion bash > ~/.profile.d/minishift.sh
}
