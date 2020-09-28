install-gradle() {
 [[ ! -d "$HOME/.local/share/gradle" ]] && mkdir -p "$HOME/.local/share/gradle"

 temp=$(mktemp -d) \
 && curl -LO 'https://services.gradle.org/distributions/gradle-5.6.2-bin.zip' \
 && unzip -d "$temp" \*.zip \
 && rm -rf \*.zip \
 && mv "$temp"/* "$HOME/.local/share/gradle" \
 && rm -rf $temp

 ln -s "$HOME/.local/share/gradle/bin/gradle" "$HOME/.local/bin/gradle"

 # Install bash completion
 # curl -L 'https://raw.githubusercontent.com/juven/maven-bash-completion/master/bash_completion.bash' \
 #      -o "$HOME/.profile.d/mvn.sh"
}
