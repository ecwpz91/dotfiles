install-oc() {
 curl -L 'https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.9.11/openshift-client-linux.tar.gz' \
 | tar -xvzf - -C "$HOME/.local/bin" &>/dev/null

 # Install bash completion
 # oc completion bash > ~/.profile.d/oc.sh
}
