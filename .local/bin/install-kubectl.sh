install-kubectl() {
 curl -L "https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl" \
      -o "$HOME/.local/bin/kubectl" \
 && chmod +x "$HOME/.local/bin/kubectl"

 # Install bash completion
 # kubectl completion bash > ~/.profile.d/kubectl.sh
}
