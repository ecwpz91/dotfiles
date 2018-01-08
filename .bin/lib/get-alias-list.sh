get-alias-list() {
 local target_alias=$1; shift || return 1

 alias | grep "$target_alias" | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort

 echo "Functions available:"

 # Turn on extended shell debugging
 shopt -s extdebug

 typeset -F -p | cut -d " " -f 3 | grep "dkr" | while read -r line ; do
  echo "  ${line}"
 done

 # Turn off extended shell debugging
 shopt -u extdebug
}
