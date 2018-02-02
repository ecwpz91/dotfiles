curl-user-oc() {
 pushd /tmp &>/dev/null \
 && curl -L -O "https://mirror.openshift.com/pub/openshift-v3/clients/3.7.14/linux/oc.tar.gz" \
 && tar -xvzf oc.tar.gz -C "$HOME/.local/bin" &>/dev/null \
 && popd &>/dev/null \
 && chmod +x "$HOME/.local/bin/oc" \
 && rm -rf "$HOME/.local/bin/oc.sh" &>/dev/null \
 && oc completion bash > "$HOME/.local/bin/oc.sh"
}
