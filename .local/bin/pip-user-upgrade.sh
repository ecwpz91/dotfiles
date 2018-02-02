pip-user-upgrade() {
 [ -z "$@" ] && return 1

 if ! type pip &>/dev/null; then
  temp=$(mktemp -d) \
  && pushd "$temp" \
  && wget https://bootstrap.pypa.io/get-pip.py \
  && python get-pip.py --user \
  && popd && rm -rf "$temp"
 fi

 for pkg in "$@"; do
  pip install --user --upgrade "$pkg"
 done
}
