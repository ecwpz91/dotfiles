syslog-pass() {
 printf "\xE2\x9C\x94 [%s PASS] %s\n" "$(date +'%a %b %d %T')" "${1:-}"
}
