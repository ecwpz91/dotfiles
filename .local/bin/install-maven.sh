install-maven() {
 [[ ! -d "$HOME/.local/share/maven" ]] && mkdir -p "$HOME/.local/share/maven"

 curl -L 'http://www.gtlib.gatech.edu/pub/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz' \
 | tar -xzf - -C "$HOME/.local/share/maven" --strip 1

 ln -s "$HOME/.local/share/maven/bin/mvn" "$HOME/.local.local/bin/mvn"
}
