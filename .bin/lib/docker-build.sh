docker-build() {
 local ctag=$1; shift || return 1

 if ! docker build -t=${ctag} . 2>/dev/null; then
  printf "fail: ${FUNCNAME[0]}: %s\n" "docker build -t=${ctag} ."
  return 1
 fi
}
