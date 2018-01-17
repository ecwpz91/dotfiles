git-latest-release() {
 local fcn="${FUNCNAME[0]}"
 local ost="unknown"
 local bit="unknown"

 [[ "$(uname)" == "Linux" && "$(uname -m)" == "x86_64" ]] \
 && ost="$(uname)";ost="${ost,,}"; bit="64"

 declare -r fcn ost bit

 usage() {
	  cat <<EOF
Usage: ${fcn:-} [GITHUB_USER] [GITHUB_REPO]
EOF
 }

 save() {
  for i do printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/" ; done
  echo " "
 }

 main() {
  local user=$1
  local repo=$2; shift 2 || { usage >&2; return 1; }
  local urls=( $( save "`curl -s https://api.github.com/repos/${user:-}/${repo:-}/releases \
  | grep browser_download_url \
  | cut -d '"' -f 4 `") )

  for i in "${urls[@]}"; do
   echo $i
  done
 }

 main "${@}"
}
