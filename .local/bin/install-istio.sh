install-istio() {
 [[ ! -d "$HOME/.local/share/istio" ]] && mkdir -p "$HOME/.local/share/istio"

 curl -L 'https://github.com/istio/istio/releases/download/1.8.2/istio-1.8.2-linux-amd64.tar.gz' \
 | tar -xzf - -C "$HOME/.local/share/istio" --strip 1

 ln -s "$HOME/.local/share/istio/bin/istioctl" "$HOME/.local/bin/istioctl"
}
