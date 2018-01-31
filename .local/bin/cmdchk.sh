cmdchk() {
 local cmd=$1; shift || return 1

 type "$cmd" &>/dev/null || return 1
}
