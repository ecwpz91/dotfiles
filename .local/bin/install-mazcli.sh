install-mazcli() {
 local pypkgs

 pypkgs='azure-cli pycrypto colorama websocket-client'

 pip install --upgrade --user $pypkgs
}
