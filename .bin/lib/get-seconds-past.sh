get-seconds-past() {
 local fromtime=$1; shift || return 1
 local currtime
 currtime=$(date +%s)

 echo "$(expr $currtime - $fromtime)"
}
