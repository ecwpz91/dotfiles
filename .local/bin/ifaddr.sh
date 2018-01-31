ifaddr() {
 local ifname=$1; shift || return 1

 printf "%s\n" "$(ip a l " $ifname" | grep 'inet ' | cut -d' ' -f6 | awk -F'/' '{ print $1}')"
}
