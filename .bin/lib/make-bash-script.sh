make-bash-script() {
 local fcn="${FUNCNAME[0]}"
 local des="Create a new bash script"
 local maj='1'
 local min='0'
 local pat='0'
 local ver="${maj}.${min}"
 local rel="${ver}.${pat}"

 # Mark read only vars
 declare -r fcn des maj min pat ver rel

 usage() {
	  cat <<EOF
Usage: ${fcn:-} [FILENAME]

${des:-}

Options:
  -D, --debug                     Enable debug mode
  -h, --help                      Print usage
  -v, --version                   Print version information and quit
EOF

  [ ${debug:-} ] && syslog "Debug mode true"
 }

 release(){
  printf "%s, release %s\n" "${fcn:-}" "${rel:-}"
 }

 syslog() {
  local msg=${1:-'No information provided'}; shift
  local log=${1:-'DEBUG'}

  printf "%s [%s] %s\n" "$(date +%T)" "${log}" "${msg}"
 }

 main() {
  local OPTARG OPTIND opt debug targs mycmd

  while getopts ":-:Dv" opt; do
   case ${opt} in
    -  ) case "${OPTARG:-}" in
      debug   ) debug='true' ;;
      version ) release; return 1 ;;
      *       ) usage; return 1
      ;;
    esac ;;
    D  ) debug='true' ;;
    v  ) release; return 1 ;;
    \? ) usage; return 1
   esac
  done

  shift $(($OPTIND - 1));

  # Check null argument
  if [[ -z "${@}" ]]; then
   [ ${debug:-} ] && syslog "Null input args"
   usage; return 1
  fi

  [ ${debug:-} ] && syslog "Run"

  for i in "${@}"; do
   [ ${debug:-} ] && syslog "Exec input args"
  done

  [ ${debug:-} ] && syslog "End"
 }

 main "${@}"
}
