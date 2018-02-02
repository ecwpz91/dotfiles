wget-user-jq() {
 if ! type jq &>/dev/null; then
  temp=$(mktemp -d) \
  && pushd "$temp" &>/dev/null \
  && wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq \
  && cp -rf jq "$HOME/.local/bin/jq" \
  && chmod +x "$HOME/.local/bin/jq" \
  && popd &>/dev/null \
  && rm -rf "$temp"
 fi
}
