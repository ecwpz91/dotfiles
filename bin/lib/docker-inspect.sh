docker-inspect() {
 local OPTIND opt maj_ver min_ver pat_ver sem_ver cmd_opts tmp_dir

 maj_ver="1"
 min_ver="0"
 pat_ver="0"
 sem_ver="$maj_ver\.$min_ver\.$pat_ver"
 func_id="${FUNCNAME[0]}"

 _usage() {
  cat << EOF
Usage: $func_id [-o OPTIONS] COMMAND
EOF
 }

 while getopts ":o:" opt; do
  case $opt in
   o  ) cmd_opts=$OPTARG ;;
   \? ) opt_ary=( "$@" ); opt_var="${opt_ary[$(($OPTIND - 2))]}"
   printf "%s\n" "$func_id: Illegal option '$opt_var'" && return 1 ;;
  esac
 done

 shift $(($OPTIND - 1))

 if [ -z "$@" ]; then
  _usage && return 1;
 fi

 for mod_name in "$@"; do

  # [TODO] add volumes
  # dkrvls() {
  #  find '/var/lib/docker/volumes/' -mindepth 1 -maxdepth 1 -type d | grep -vFf <(
  #   docker ps -aq | xargs docker inspect | jq -r '.[]|.Mounts|.[]|.Name|select(.)'
  #  );
  # }

  # [TODO] fix commnads
  case $mod_name in
   lc ) result=$(docker inspect "$(docker ps ${cmd_opts:-'-n 1'} 2>/dev/null)" 2>/dev/null) ;;
   * ) printf "%s\n" "$func_id: Unknown command '$mod_name'" && return 1 ;;
  esac

  if [ $? != 0 ] ; then
   printf "%s\n" "$func_id: Command failed '$result'" && return 1
  fi

  # Checks if command in hash table exists before executing it
  shopt -s checkhash

  if ! hash jq 2>/dev/null ; then
   tmp_dir=$(mktemp -d) \
   && pushd $tmp_dir &>/dev/null \
   && wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq \
   && cp -rf jq $HOME/.local/bin/jq \
   && chmod +x $HOME/.local/bin/jq \
   && popd &>/dev/null \
   && rm -rf $tmp_dir
  fi

  shopt -u checkhash

  printf "%s" "$result" | jq
 done
}
