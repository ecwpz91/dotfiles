syslog-fail() {
 printf "\xe2\x9c\x98 [%s FAIL] %s\n" "$(date +'%a %b %d %T')" "${1:-}"
}
