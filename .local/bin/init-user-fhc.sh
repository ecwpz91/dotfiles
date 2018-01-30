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
  if ! type n &>/dev/null; then
   echo "$(envs)" >> $HOME/.bashrc
   source $HOME/.bashrc
   curl -L https://git.io/n-install | bash
  fi

  npm install -g fh-fhc
  fhc completion bash > $HOME/.local/bin/fhc.sh
 }

 main "${@}"
}
