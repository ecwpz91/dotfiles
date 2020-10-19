install-graal-vm() {
 [[ ! -d "$HOME/.local/share/graalvm" ]] && mkdir -p "$HOME/.local/share/graalvm"

 curl -L 'https://github.com/oracle/graal/archive/vm-20.2.0.tar.gz' \
 | tar -xzf - -C "$HOME/.local/share/graalvm" --strip 1
}