ifaddr() {
 local ifn=$1; shift || return 1

 printf "%s\n" "$(ip a l " $ifn" | grep 'inet ' | cut -d' ' -f6 | awk -F'/' '{ print $1}')"
}
