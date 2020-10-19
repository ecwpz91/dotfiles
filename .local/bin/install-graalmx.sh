install-graalmx() {
 [[ ! -d "$HOME/.local/share/graalmx" ]] && mkdir -p "$HOME/.local/share/graalmx"

 curl -L 'https://github.com/graalvm/mx/archive/5.273.10.tar.gz' \
 | tar -xzf - -C "$HOME/.local/share/graalmx" --strip 1

 ln -s "$HOME/.local/share/graalmx/mx" "$HOME/.local/bin/mx"

 ln -s "$HOME/.local/share/graalmx/bash_completion/mx" "$HOME/.profile.d/mx.sh"
}