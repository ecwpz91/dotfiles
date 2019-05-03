install-flash() {
 curl -L https://github.com/hypriot/flash/releases/download/2.3.0/flash \
      -o "$HOME/.local/bin/flash" \
&& chmod +x "$HOME/.local/bin/flash"
}
