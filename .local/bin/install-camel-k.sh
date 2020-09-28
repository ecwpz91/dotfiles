install-camel-k () {
 curl -L 'https://github.com/apache/camel-k/releases/download/1.0.0-RC1/camel-k-client-1.0.0-RC1-linux-64bit.tar.gz' \
  | tar -xvzf - -C "$HOME/.local/bin" --strip 1 &>/dev/null
}
