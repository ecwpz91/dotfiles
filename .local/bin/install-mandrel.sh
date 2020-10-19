install-mandrel() {
 [[ ! -d "$HOME/.local/share/mandrel" ]] && mkdir -p "$HOME/.local/share/mandrel"

 curl -L 'https://github.com/graalvm/mandrel/releases/download/mandrel-20.1.0.2.Final/mandrel-java11-linux-amd64-20.1.0.2.Final.tar.gz' \
 | tar -xzf - -C "$HOME/.local/share/mandrel" --strip 1
}