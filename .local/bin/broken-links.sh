broken-links() {
 set +e
 
 for element in $1/*; do
  [ -h "${element:-}" -a ! -e "${element:-}" ] && printf "%s\n" "${element:-}"
  [ -d "${element:-}" ] && chk-symlinks "${element:-}"
 done

 set -e
}
