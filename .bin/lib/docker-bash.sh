docker-bash() {
 local name=${1:-}
 local rslt

 if [[ -z "${name}" ]]; then
  rslt="$(docker ps -aq -n 1_NAME)"
 else
  rslt="$(docker ps -aqf name=${name:-})"
 fi

 if ! docker exec -it ${rslt} bash 2>/dev/null; then
  printf "fail: ${FUNCNAME[0]}: %s\n" "docker exec -it ${rslt} bash"
  return 1
 fi
}
