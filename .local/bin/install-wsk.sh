install-wsk() {
 curl -L 'https://github.com/apache/openwhisk-cli/releases/download/1.1.0/OpenWhisk_CLI-1.1.0-linux-amd64.tgz' \
 | tar -xvzf - -C "$HOME/.local/bin" wsk &>/dev/null

 # Install bash completion
 # wsk sdk install bashauto --stdout > ~/.profile.d/wsk.sh
}
