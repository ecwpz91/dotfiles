docker-rm-container() {
 local name=${1:-}
 local rslt

 if [[ -z "${name}" ]]; then
  rslt=( $(docker ps -aq) )
 else
  rslt=( "$(docker ps -aqf name=${name:-})" )
 fi

 if ! ${#rslt[@]}; then
  for c in "${rslt[@]}"; do
   if ! docker rm ${c} 2>/dev/null; then
    printf "fail: ${FUNCNAME[0]}: %s\n" "docker rm -it ${c} bash" >&2; return 1
   fi
  done
 fi
}
