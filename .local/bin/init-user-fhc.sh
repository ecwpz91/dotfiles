init-user-fhc() {

 envs(){
  cat <<EOF
  # ----------------------------------------------------------------------
  # Node.js
  # ----------------------------------------------------------------------
  export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin" # Added by n-install (see http://git.io/n-install-repo).
EOF
 }

 main() {
  local flagset

  [[ ! $(shopt checkhash &>/dev/null) ]] && shopt -s checkhash; flagset=true

  if ! hash n 2>/dev/null ; then
   echo "$(envs)" >> $HOME/.bashrc
   source $HOME/.bashrc
   curl -L https://git.io/n-install | bash
  fi

  npm install -g fh-fhc
  fhc completion bash > $HOME/.local/bin/fhc.sh

  [[ ${flagset:-} ]] && shopt -u checkhash; flagset=false
 }

 main "${@}"
}
