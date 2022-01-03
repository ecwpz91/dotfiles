install-s2i() {
 curl -L 'https://github.com/openshift/source-to-image/releases/download/v1.3.1/source-to-image-v1.3.1-a5a77147-linux-amd64.tar.gz' \
 | tar -xvzf - -C $HOME/.local --strip 1 &>/dev/null

 # Install bash completion
 # s2i completion bash > ~/.profile.d/s2i.sh
}
