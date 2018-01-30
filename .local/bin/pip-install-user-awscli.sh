pip-install-user-awscli() {
 if type pip &>/dev/null; then
  pip install --upgrade --user pip awscli boto boto3

  if ! grep -R aws_completer $HOME/.bashrc &>/dev/null; then
   printf "%s\n" "complete -C $HOME/.local/bin/aws_completer aws"  >> $HOME/.bashrc
   source $HOME/.bashrc
  fi
 fi
}
