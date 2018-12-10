install-jvmtop() {
 curl -L 'https://github.com/patric-r/jvmtop/releases/download/0.8.0/jvmtop-0.8.0.tar.gz' \
 | tar -xvzf - -C "$HOME/.local/bin" jvmtop.jar &>/dev/null
}
