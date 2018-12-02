install-jpsstat() {
 curl -L 'https://raw.githubusercontent.com/amarjeetanandsingh/jps_stat/master/jpsstat.sh' \
      -o "$HOME/.local/bin/jpsstat.sh" \
 && chmod +x "$HOME/.local/bin/jpsstat.sh"
}
