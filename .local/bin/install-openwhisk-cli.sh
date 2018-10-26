install-openwhisk-cli() {
 curl -L 'https://github.com/apache/incubator-openwhisk-cli/releases/download/latest/OpenWhisk_CLI-latest-linux-amd64.tgz' \
 | tar -xvzf - -C "$HOME/.local/bin" wsk &>/dev/null
}
