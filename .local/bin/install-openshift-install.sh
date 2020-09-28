install-openshift-install() {
 curl -L 'https://github.com/openshift/installer/releases/download/v0.12.0/openshift-install-linux-amd64' \
      -o "$HOME/.local/bin/openshift-install" \
 && chmod +x "$HOME/.local/bin/openshift-install"

 curl -L 'https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux-4.1.8.tar.gz' \
 | tar -xvzf - -C "$HOME/.local/bin" &>/dev/null

 # Install bash completion
 # oc completion bash > ~/.profile.d/oc.sh
}
