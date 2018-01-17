docker-stop() {
 local name=${1:-}
 local rslt

 if [[ -z "${name}" ]]; then
  rslt=( $(docker ps -aq) )
 else
  rslt=( $(docker ps -aqf name=${name:-}) )
 fi

 if ! ${#rslt[@]}; then
  for c in "${rslt[@]}"; do
   if ! docker stop ${c} 2>/dev/null; then
    printf "fail: ${FUNCNAME[0]}: %s\n" "docker stop -it ${c} bash"
    return 1
   fi
  done
 fi
}
