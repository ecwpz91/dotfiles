check-command() {
 local mycomm=$1; shift || return 1

 hash $mycomm 2>/dev/null || return 1
}
