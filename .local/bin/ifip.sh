ifip() {
 local ifname=$1; shift || { printf "%s\n" "Usage: get-interface-ipaddress [DEVICE]" >&2; return 1; }

 if ! ip address show up dev ${ifname:-} &>/dev/null; then
  printf "%s\n" "Device '${ifname:-}' does not exist" >&2; return 1
 fi

 printf "%s\n" "$(ip a l ${ifname:-} | grep 'inet ' | cut -d' ' -f6 | awk -F'/' '{ print $1}')"
}
