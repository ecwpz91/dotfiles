function git-excludes() {
 usage() {
  printf "%s\n" "Usage: git-excl-aux [DIRECTORY] [PATTERN(S)]" >&2; return 1;
 }

 get-base-dir() {
  local relative_path=$1; shift || { printf "%s\n" "Usage: get-base-dir [DIRECTORY]" >&2; return 1; }
  local absolute_path

  if pushd "$relative_path" &>/dev/null; then
   absolute_path="$(pwd)"

   if [[ -h "$absolute_path" ]]; then
    absolute_path="$( readlink "$absolute_path" )"
   fi

   popd &>/dev/null
  fi

  printf "%s\n" "$( cd -P "$( dirname "$absolute_path" )" && pwd )"
 }

 main() {
  local excl="$(get-base-dir $excl/.git)/.git/info/exclude"; shift || usage

  for i in "${@}"; do
   if ! grep -Fxq $i "$excl" 2>/dev/null; then
    printf "%s\n" "$i" >> $excl
   fi
  done

 }

 main "${@}"
}
