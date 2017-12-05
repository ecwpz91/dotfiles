#!/usr/bin/env bash

ANSIBLE=$HOME/.local/bin/ansible

function ansible-jq() {
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
   debug ) result=$($ANSIBLE localhost -m debug -a ${mod_args:-'var=hostvars[inventory_hostname]'} -o 2>/dev/null) ;;
   setup ) result=$($ANSIBLE localhost -m setup -a ${mod_args:-'gather_subset=!all,!min,env'} -o 2>/dev/null) ;;
   * ) printf "%s\n" "$func_id: Unknown command '$mod_name'" && return 1 ;;
  esac

  if [ $? != 0 ] ; then
   printf "%s\n" "$func_id: Command failed '$result'" && return 1
  fi

  # Checks if command in hash table exists before executing it
  shopt -s checkhash

  if ! hash jq 2>/dev/null ; then
   temp=$(mktemp -d) \
   && pushd ${temp} &>/dev/null \
   && wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq \
   && cp -rf jq $HOME/.local/bin/jq \
   && chmod +x $HOME/.local/bin/jq \
   && popd &>/dev/null \
   && rm -rf ${temp}
  fi

  shopt -u checkhash

  printf "%s" "${result#*=>}" | jq
 done
}
