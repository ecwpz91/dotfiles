install-graalvm() {
 [[ ! -d "$HOME/.local/share/graalvm" ]] && mkdir -p "$HOME/.local/share/graalvm"

 curl -L 'https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.2.0/graalvm-ce-java8-linux-amd64-20.2.0.tar.gz' \
 | tar -xzf - -C "$HOME/.local/share/graalvm" --strip 1
}