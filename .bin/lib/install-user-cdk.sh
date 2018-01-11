install-user-cdk(){
 local bincdk=${1:-'HOME/Downloads/cdk-3.2.0-1-minishift*'}
 local cdkuri="https://developers.redhat.com/download-manager/file/cdk-3.2.0-1-minishift-linux-amd64"

 if ! -f $bincdk; then
  printf "%s\n" "Vist $cdkuri for CDK download" >&2; return 1;
 fi

 # Add yourself to the libvirt group so that you do not need to sudo
 printf "%s " "root@${HOSTNAME}"; su - root -c 'yum install libvirt qemu-kvm -y
	                                         newgrp libvirt
	                                         usermod -a -G libvirt ${USER}
	                                         systemctl start libvirtd
	                                         systemctl enable libvirtd
	                                         curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm -o /usr/local/bin/docker-machine-driver-kvm
	                                         chmod +x /usr/local/bin/docker-machine-driver-kvm
 '

 # Check if Docker machine exists, if not install locally
 # sudo curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` -o /usr/local/bin/docker-machine \
 # && sudo chmod +x /usr/local/bin/docker-machine-driver-kvm

 # Check if minishift exists, if not install locally
 mv $bincdk $HOME/.local/bin/minishift \
 && chmod +x $HOME/.local/bin/minishift

 [ ! -d $HOME/.minishift ] \
 && minishift setup-cdk \
 && minishift config set memory 4096 &>/dev/null \
 && minishift config set cpus 2  &>/dev/null

 get_export() {
 cat <<EOF
# ----------------------------------------------------------------------
# Minishift
# ----------------------------------------------------------------------
# export MINISHIFT_VM_DRIVER=
# export MINISHIFT_USERNAME=
# export MINISHIFT_PASSWORD=

EOF
 }

 echo "$(get_export)" >> $HOME/.bashrc
}
