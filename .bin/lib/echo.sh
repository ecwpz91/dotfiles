# See http://www.etalabs.net/sh_tricks.html

echo () (
 fmt=%s end=\\n IFS=" "

 while [ $# -gt 1 ] ; do
  case "$1" in
   [!-]*|-*[!ne]*) break ;;
   *ne*|*en*) fmt=%b end=;;
   *n*) end=;;
   *e*) fmt=%b ;;
  esac
  shift
 done

 [[ $fmt == %b ]] && printf "%b$end" "$*" || printf "%s$end" "$*"
)
