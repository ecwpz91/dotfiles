install-packer() {
 temp=$(mktemp -d) \
 && curl -LO 'https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_linux_amd64.zip' \
 && unzip -d "$temp" \*.zip \
 && rm -rf \*.zip \
 && mv "$temp"/* "$HOME/.local/bin" \
 && rm -rf $temp
}
