npm-user-package() {
 [ -z "$@" ] && return 1

 if ! type n &>/dev/null; then
  curl -L https://git.io/n-install | bash
 fi

 for pkg in "$@"; do
  npm install --global "$pkg"
 done
}
