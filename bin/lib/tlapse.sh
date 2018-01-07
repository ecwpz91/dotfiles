#!/usr/bin/env bash

function tlapsed() {
 local FCN="${FUNCNAME[0]}"
 local DES="A time elapsed calculator"

 #----------------------------------------------------
 # Semantic Versioning
 #----------------------------------------------------
 local MAJ='1'
 local MIN='0'
 local VER="${MAJ}.${MIN}"
 local PAT='0'
 local REL="${VER}.${PAT}"

 # Check if git exists
 args=( $(hash git 2>/dev/null) ); [ "${args[@]}" ]; \
 local BLD="$(git show -s --format=%h 2>/dev/null)" \
 && unset args

 #----------------------------------------------------
 # Predefined Commands
 #----------------------------------------------------
 local EX0='get_usage; return 1'
 local EX1='get_build; return 1'

 # Mark read only vars
 declare -r FCN MAJ MIN VER PAT REL BLD EX0 EX1

 get_usage() {
  cat <<EOF
Usage: ${FCN:-} [OPTIONS] START_TIME
       ${FCN:-} [ --help | -v | --version ]

${DES:-}

Options:

  -D                              Enable debug mode
  -h                              Print usage
  -v                              Print version information and quit
EOF
 }

 get_build() {
  printf "%s version %s, build %s/%s\n" "${FCN:-}" "${REL:-}" "${BLD:-}" "${REL:-}"
 }

 debug_msg() {
  local debug_string=$1; shift || return 1

  printf "%s\n" "DEBUG[${debug_string:-}]"
 }

 get_absolute_path() {
  local relative_path="$1"
  local get_absolute_path

  pushd "${relative_path}" >/dev/null
  relative_path="$( pwd )"
  if [[ -h "${relative_path}" ]]; then
   get_absolute_path="$( readlink "${relative_path}" )"
  else
   get_absolute_path="${relative_path}"
  fi
  popd >/dev/null

  printf "%s" "${get_absolute_path}"
 }

 main() {
  local OPTARG OPTIND opt debug targs mycmd

  while getopts ":-:Dv" opt; do
   case ${opt} in
    -  ) case "${OPTARG:-}" in
      version ) eval ${EX1:-}
      ;;
    esac ;;
    D  ) debug='true' ;;
    v  ) eval ${EX1:-} ;;
    \? ) eval ${EX0:-} ;;
   esac
  done

  shift $(($OPTIND - 1));

  # Check null argument
  if [[ -z "${@}" ]]; then
   eval ${EX0:-}
  fi

  # Process target args
  for input in "${@}"; do
   [ ${debug:-} ] && debug_msg "Run"

   if [[ "${input}" != "${1}" ]]; then
    printf "\n"; [ ${debug:-} ] && debug_msg "${input:-}"
   else
    [ ${debug:-} ] && debug_msg "${input:-}"
   fi

   targs="$(date +%s)"

   [ ${debug:-} ] && debug_msg "${targs:-}"

   mycmd=""$(($(date +%s) - ${input:-}))""

   printf "%s seconds\n" "${mycmd:-}"
  done

  [ ${debug:-} ] && debug_msg "End"
 }

 main "${@}"
}
