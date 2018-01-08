syslog-info() {
 printf "\xE2\x9E\xA1 [%s INFO] %s\n" "$(date +'%a %b %d %T')" "${1:-}"
}
