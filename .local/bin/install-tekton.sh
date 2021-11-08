install-tekton() {
  curl -L 'https://github.com/tektoncd/cli/releases/download/v0.21.0/tkn_0.21.0_Linux_x86_64.tar.gz' \
  | tar -xvzf - -C "$HOME/.local/bin" tkn &>/dev/null
}