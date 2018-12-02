install-s2i() {
 curl -L 'https://github.com/openshift/source-to-image/releases/download/v1.1.9a/source-to-image-v1.1.9a-40ad911d-linux-amd64.tar.gz' \
 | tar -xvzf - -C $HOME/.local --strip 1 &>/dev/null

 # Install bash completion
 # s2i completion bash > ~/.profile.d/s2i.sh
}
