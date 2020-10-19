install-graal-mx() {
 [[ ! -d "$HOME/.local/share/graal-mx" ]] && mkdir -p "$HOME/.local/share/graal-mx"

 curl -L 'https://github.com/graalvm/mx/archive/5.273.10.tar.gz' \
 | tar -xzf - -C "$HOME/.local/share/graal-mx" --strip 1

 ln -s "$HOME/.local/share/graal-mx/mx" "$HOME/.local/bin/mx"

 ln -s "$HOME/.local/share/graal-mx/bash_completion/mx" "$HOME/.profile.d/mx.sh"
}