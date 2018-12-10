# .bashrc

if [ -f /etc/bashrc ]; then
 . /etc/bashrc
fi

# User specific environment and startup programs

set -o noclobber

export PATH=$PATH:$HOME/.local/bin:$HOME/bin

cd2() {
 arg=() dir= cmd= IFS=" " msg='[-L|[-P [-e]]|-h] [dir|file]'

 while [ "$#" -gt 1 ] ; do
  case "$1" in
   -h) printf "%s: cd2 %s\n" "$0" "$msg"
    return 1 ;;
   *) arg+=("$1") ;;
  esac
  shift
 done

 [ -f "${1:-}" ] && dir="$(dirname ${1:-})" || dir="${1:A}"
 [ ! -z "$arg" ] && cmd="cd ${arg[@]} $dir" || cmd="cd $dir"

 if ! $cmd 2>/dev/null; then
  printf "%s: cd2 %s\n" "$0" "$msg"
  return 1
 fi
}

echo2() {
 fmt=%s end=\\n IFS=" "

 while [ "$#" -gt 1 ] ; do
  case "$1" in
   [!-]*|-*[!ne]*) break ;;
   *ne*|*en*) fmt=%b end= ;;
   *n*) end= ;;
   *e*) fmt=%b ;;
  esac
  shift
 done

 [[ "$fmt" == %b ]] && printf "%b$end" "$*" || printf "%s$end" "$*"
}

ifaddr() {
 local ifn=$1; shift || return 1

 printf "%s\n" "$(ip a l "$ifn" | grep 'inet ' | cut -d' ' -f6 | awk -F'/' '{ print $1}')"
}

lnchk() {
 for element in $1/*; do
  [ -h "$element" -a ! -e "$element" ] && echo \"$element\"
  [ -d "$element" ] && lnchk "$element"
 done
}

if [ -d ~/.profile.d ]; then
 ARR=( $HOME/.profile.d/* ) \
  && for i in "${ARR[@]}"; do . "$i"; done \
  && unset ARR
fi
