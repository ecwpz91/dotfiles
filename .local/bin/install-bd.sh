install-bd() {
 curl -L 'https://raw.githubusercontent.com/vigneshwaranr/bd/master/bd' \
      -o "$HOME/.local/bin/bd" \
 && chmod +x "$HOME/.local/bin/bd"

 # Install bash completion
 # curl -L 'https://raw.githubusercontent.com/vigneshwaranr/bd/master/bash_completion.d/bd' \
 #      -o "$HOME/.profile.d/bd.sh"
}
