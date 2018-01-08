docker-names(){
 local fmt='--format {{.Names}}'
 local cmd="docker ps -aq $fmt"

 if ! $cmd; then
  printf "fail: ${FUNCNAME[0]}: %s\n" "$cmd" >&2; return 1
 fi
}
