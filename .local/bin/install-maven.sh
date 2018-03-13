install-maven() {
 [[ ! -d ~/.local/share/maven ]] && mkdir -p ~/.local/share/maven

 curl -L "http://apache.mesi.com.ar/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz" \
 | tar -xzf - -C ~/.local/share/maven --strip 1

 ln -s ~/.local/share/maven/bin/mvn ~/.local/bin/mvn
}
