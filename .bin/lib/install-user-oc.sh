install-user-oc() {
 curl -L -O 'https://mirror.openshift.com/pub/openshift-v3/clients/3.7.22/linux/oc.tar.gz' | tar -xvzf - -C $HOME/.local/bin \
 && chmod +x $HOME/.local/bin/oc \
 && rm -rf $HOME/.local/bin/oc.sh &>/dev/null \
 && oc completion bash > $HOME/.local/bin/oc.sh
}
