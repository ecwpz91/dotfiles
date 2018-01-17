pip-install-user-awscli() {
 local flagset

 [[ ! $(shopt checkhash &>/dev/null) ]] && shopt -s checkhash; flagset=true

 if hash pip 2>/dev/null; then
  pip install --upgrade --user pip awscli boto boto3

  if ! grep -R aws_completer $HOME/.bashrc &>/dev/null; then
   printf "%s\n" "complete -C $HOME/.local/bin/aws_completer aws"  >> $HOME/.bashrc
   source $HOME/.bashrc
  fi
 fi

 [[ ${flagset:-} ]] && shopt -u checkhash; flagset=false
}
