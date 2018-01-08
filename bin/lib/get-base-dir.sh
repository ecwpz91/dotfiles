function get-base-dir() {
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
