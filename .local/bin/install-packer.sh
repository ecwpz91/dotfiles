install-packer() {
 temp=$(mktemp -d) \
 && curl -LO 'https://releases.hashicorp.com/packer/1.2.3/packer_1.2.3_linux_amd64.zip' \
 && unzip -d "$temp" \*.zip \
 && rm -rf \*.zip \
 && mv "$temp"/* "$HOME/.local" \
 && rm -rf $temp
}
