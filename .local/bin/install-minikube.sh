install-minikube() {
 sudo /bin/bash -c 'yum -y install libvirt-daemon-kvm qemu-kvm
                    usermod -a -G libvirt $USER

                    curl -L https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-`uname -s`-`uname -m` \
                         -o /usr/local/bin/docker-machine \
                    && chmod +x /usr/local/bin/docker-machine

                    curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 \
                         -o /usr/local/bin/docker-machine-driver-kvm \
                    && chmod +x /usr/local/bin/docker-machine-driver-kvm

                    curl -L https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 \
                         -o /usr/local/bin/docker-machine-driver-kvm2 \
                    && chmod +x /usr/local/bin/docker-machine-driver-kvm2
 '

 curl -L 'https://github.com/kubernetes/minikube/releases/download/v0.35.0/minikube-linux-amd64' \
      -o "$HOME/.local/bin/minikube" \
 && chmod +x "$HOME/.local/bin/minikube"

 # Install bash completion
 # minikube completion bash > ~/.profile.d/minikube.sh
}
