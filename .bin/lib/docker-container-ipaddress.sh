docker-container-ipaddress(){
 local fmt='--format {{ .NetworkSettings.IPAddress }}'
 local cmd="docker ps -aqf name=${1:-} $fmt"

 if ! $cmd; then
  printf "fail: ${FUNCNAME[0]}: %s\n" "$cmd" >&2; return 1
 fi
}
