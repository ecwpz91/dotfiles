install-ansible() {
 if ! type pip &>/dev/null; then
  temp=$(mktemp -d) \
  && pushd $temp &>/dev/null \
  && curl -LO 'https://bootstrap.pypa.io/get-pip.py' \
  && python get-pip.py --user \
  && popd &>/dev/null && rm -rf $temp
 fi

 pip install --upgrade --user pip ansible cryptography passlib
}
