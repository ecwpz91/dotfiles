install-tekton() {
  curl -L 'https://github.com/tektoncd/cli/releases/download/v0.15.0/tkn_0.15.0_Linux_x86_64.tar.gz' \
  | tar -xvzf - -C "$HOME/.local/bin" tkn &>/dev/null
}