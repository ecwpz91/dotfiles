install-argocd() {
 curl -L 'https://github.com/argoproj/argo-cd/releases/download/v2.1.5/argocd-linux-amd64' \
      -o "$HOME/.local/bin/argocd" \
 && chmod +x "$HOME/.local/bin/argocd"
}