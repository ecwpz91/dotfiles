install-java-11-openjdk() {
 [[ ! -d "$HOME/.local/share/java-11-openjdk" ]] && mkdir -p "$HOME/.local/share/java-11-openjdk"

 curl -L 'https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz' \
 | tar -xzf - -C "$HOME/.local/share/java-11-openjdk" --strip 1
}

