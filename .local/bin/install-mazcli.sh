install-mazcli() {
 pip install --upgrade --user azure-cli pycrypto colorama websocket-client

 if [[ -f ~/.local/bin/az ]]; then
  [[ ! -f ~/.local/bin/azure ]] && ln -s ~/.local/bin/az ~/.local/bin/azure
 fi
}
