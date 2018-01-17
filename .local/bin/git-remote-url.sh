git-remote-url() {
 rmt=$1; shift || { printf "%s\n" "Usage: git-remote-url [REMOTE]" >&2; return 1;}
 rmt=$1; shift || { printf "%s\n" "Error: not a valid remote name" >&2; return 1;}; \

 url=`git config --get remote.${rmt}.url` || { printf "%s\n" "Error: not a valid remote name" >&2; return 1;}; \
 [[ $url == git@* ]] && { url="https://github.com/${url##*:}" >&2; }; \
 { url="${url%%.git}" >&2; }; \
 printf "%s\n" "$url"
}
