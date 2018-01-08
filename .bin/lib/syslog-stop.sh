syslog-stop() {
 printf "\xE2\x9E\xA1 [%s STOP] %s\n" "$(date +'%a %b %d %T')" "${1:-}"
}
