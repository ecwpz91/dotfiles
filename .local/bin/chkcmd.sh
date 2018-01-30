chkcmd () {
 local mycomm=$1; shift || return 1

 type $mycomm &>/dev/null || return 1
}
