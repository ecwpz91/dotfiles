linkchk() {
 for element in $1/*; do
  [ -h "$element" -a ! -e "$element" ] && echo \"$element\"
  [ -d "$element" ] && linkchk "$element"
 done
}
