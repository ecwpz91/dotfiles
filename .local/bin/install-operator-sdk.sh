install-operator-sdk() {
 RELEASE_VERSION=v0.17.0
 
 curl -L "https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu" \
  -o "$HOME/.local/bin/operator-sdk" \
  && chmod +x "$HOME/.local/bin/operator-sdk"
}
