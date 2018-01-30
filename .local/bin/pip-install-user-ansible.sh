pip-install-user-ansible() {
 if type pip &>/dev/null; then
  pip install --upgrade --user pip ansible cryptography passlib
 fi
}
