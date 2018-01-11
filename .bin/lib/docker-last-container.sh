docker-last-container(){
 local cmd="docker ps -n 1"

 if ! $cmd; then
  printf "fail: ${FUNCNAME[0]}: %s\n" "$cmd" >&2; return 1
 fi
}
