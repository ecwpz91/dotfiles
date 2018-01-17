get-user-jq() {
 local flagset

 [[ ! $(shopt checkhash &>/dev/null) ]] && shopt -s checkhash; flagset=true

 if ! hash jq 2>/dev/null ; then
  temp=$(mktemp -d) \
  && pushd ${temp} &>/dev/null \
  && wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq \
  && cp -rf jq $HOME/.local/bin/jq \
  && chmod +x $HOME/.local/bin/jq \
  && popd &>/dev/null \
  && rm -rf ${temp}
 fi

 [[ ${flagset:-} ]] && shopt -u checkhash; flagset=false
}
