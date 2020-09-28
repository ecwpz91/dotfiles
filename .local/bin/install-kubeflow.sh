install-kubeflow() {
 curl -L 'https://github.com/kubeflow/kubeflow/releases/download/v0.7.1/kfctl_v0.7.1-2-g55f9b2a_linux.tar.gz' \
  | tar -xvzf - -C "$HOME/.local/bin" --strip 1 &>/dev/null
}
