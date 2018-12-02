# .bashrc

if [ -f /etc/bashrc ]; then
 . /etc/bashrc
fi

# User specific environment and startup programs

set -o noclobber

export PATH=$PATH:$HOME/.local/bin:$HOME/bin

cd2() {
 local OPTIND opt arg dir cmd
 local msg='[-L|[-P [-e]]|h] [dir|file]'

 while getopts ":h" opt; do
  case $opt in
   h ) printf "bash: cd2 %s\n" "$msg"
    return 1 ;;
   \? ) arg="${arg:-}$OPTARG"
    ;;
  esac
 done

 shift $(($OPTIND - 1))

 [ -f "${1:-}" ] && dir="$(dirname ${1:-})" || dir="${1:-}"
 [ ! -z "${arg:-}" ] && cmd="cd -${arg:-} ${dir:-}" || cmd="cd ${dir:-}"

 if ! ${cmd:-} 2>/dev/null; then
  eval ${cmd:-} 2>&1 | head -n 1 | sed 's/\(.*\)cd/cd2/'
  return 1
 fi
}

if [ -d ~/.profile.d ]; then
 ARR=( $HOME/.profile.d/* ) \
  && for i in "${ARR[@]}"; do . "$i"; done \
  && unset ARR
fi
