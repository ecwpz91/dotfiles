init-user-s2i() {
 curl -L "https://github.com/openshift/source-to-image/releases/download/v1.1.8/source-to-image-v1.1.8-e3140d01-linux-amd64.tar.gz" \
 | tar -xvzf - -C $HOME/.local/bin --strip 1 &>/dev/null \
 && chmod +x $HOME/.local/bin/s2i \
 && rm -rf $HOME/.local/bin/s2i.sh &>/dev/null \
 && s2i completion bash > $HOME/.local/bin/s2i.sh
}
