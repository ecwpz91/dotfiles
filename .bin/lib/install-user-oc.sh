install-user-oc(){
 curl -L "https://mirror.openshift.com/pub/openshift-v3/clients/${1:-3.6.173.0.96}/linux/oc.tar.gz" | tar -xvzf - -C $HOME/.local/bin --strip 1 \
 && chmod +x $HOME/.local/bin/oc \
 && rm -rf $HOME/.local/bin/oc.sh &>/dev/null \
 && oc completion bash > $HOME/.local/bin/oc.sh
}
