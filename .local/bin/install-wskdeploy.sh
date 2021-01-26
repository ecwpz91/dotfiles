install-wskdeploy() {
 curl -L 'https://github.com/apache/openwhisk-wskdeploy/releases/download/latest/openwhisk_wskdeploy-latest-linux-amd64.tgz' \
 | tar -xvzf - -C "$HOME/.local/bin" wskdeploy &>/dev/null
}
