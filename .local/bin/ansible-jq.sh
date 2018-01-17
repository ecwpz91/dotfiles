ansible-jq() {
 local OPTIND opt maj_ver min_ver pat_ver sem_ver mod_args

 maj_ver="1"
 min_ver="0"
 pat_ver="0"
 sem_ver="$maj_ver\.$min_ver\.$pat_ver"
 func_id="${FUNCNAME[0]}"

 _usage() {
  cat << EOF
Usage: $func_id [-a MODULE_ARGS] MODULE_NAME
EOF
 }

 main() {
  while getopts ":a:" opt; do
   case $opt in
    a  ) mod_args=$OPTARG ;;
    \? ) opt_ary=( "$@" ); opt_var="${opt_ary[$(($OPTIND - 2))]}"
    printf "%s\n" "$func_id: Illegal option '$opt_var'" && return 1 ;;
   esac
  done

  shift $(($OPTIND - 1))

  if [ -z "$@" ]; then
   _usage && return 1;
  fi

  for mod_name in "$@"; do

   case $mod_name in
    debug ) result=$(ansible localhost -m debug -a ${mod_args:-'var=hostvars[inventory_hostname]'} -o 2>/dev/null) ;;
    setup ) result=$(ansible localhost -m setup -a ${mod_args:-'gather_subset=!all,!min,env'} -o 2>/dev/null) ;;
    * ) printf "%s\n" "$func_id: Unknown command '$mod_name'" && return 1 ;;
   esac

   if [ $? != 0 ] ; then
    printf "%s\n" "$func_id: Command failed '$result'" && return 1
   fi

   printf "%s" "${result#*=>}" | jq
  done
 }

 main "${@}"
}
