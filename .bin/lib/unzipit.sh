unzipit() {
 local zip=$1
 local dir=${2:-.}
 local tmp

 tmp=$(mktemp -d) && unzip -d "$tmp" "$zip" && mkdir -p "$dir" &&
 shopt -s dotglob && local f=("$tmp"/*) \
 && if (( ${#f[@]} == 1 )) && [[ -d "${f[0]}" ]]; then
  mv "$tmp"/*/* "$dir"
 else
  mv "$tmp"/* "$dir"
 fi \
 && rmdir "$tmp"/* "$tmp" \
 && shopt -u dotglob
}
