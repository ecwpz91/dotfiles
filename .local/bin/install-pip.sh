install-pip() {
 temp=$(mktemp -d) \
 && pushd "$temp" \
 && wget https://bootstrap.pypa.io/get-pip.py \
 && python get-pip.py --user \
 && popd && rm -rf "$temp"
}
