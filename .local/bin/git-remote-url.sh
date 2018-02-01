git-remote-url() {
 local rmt=$1; shift || return 1
 local url

 if ! git config --get remote.${rmt}.url &>/dev/null; then
  printf "%s\n" "Error: not a valid remote name" && return 1
  # Verify remote using 'git remote -v' command
 fi

 url=`git config --get remote.${rmt}.url`

 # Parse remote if local clone used SSH checkout
 [[ "$url" == git@* ]] \
 && { url="https://github.com/${url##*:}" >&2; }; \
 { url="${url%%.git}" >&2; };

 printf "%s\n" "$url"
}
