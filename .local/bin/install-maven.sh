install-maven() {
 [[ ! -d "$HOME/.local/share/maven" ]] && mkdir -p "$HOME/.local/share/maven"

 curl -L 'https://mirrors.gigenet.com/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz' \
 | tar -xzf - -C "$HOME/.local/share/maven" --strip 1

 ln -s "$HOME/.local/share/maven/bin/mvn" "$HOME/.local/bin/mvn"

 # Install bash completion
 # curl -L 'https://raw.githubusercontent.com/juven/maven-bash-completion/master/bash_completion.bash' \
 #      -o "$HOME/.profile.d/mvn.sh"
}
