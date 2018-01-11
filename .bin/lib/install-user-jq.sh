install-user-jq() {
 # Checks if command in hash table exists before executing it
 shopt -s checkhash

 if ! hash jq 2>/dev/null ; then
  temp=$(mktemp -d) \
  && pushd ${temp} &>/dev/null \
  && wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq \
  && cp -rf jq $HOME/.local/bin/jq \
  && chmod +x $HOME/.local/bin/jq \
  && popd &>/dev/null \
  && rm -rf ${temp}
 fi

 shopt -u checkhash
}
