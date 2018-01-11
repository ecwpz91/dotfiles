pip-ansible-aws() {
 if hash pip 2>/dev/null; then
  pip install -U --user pip ansible cryptography passlib boto boto3 awscli
 fi
}
