elapsed() {
 local sec=$1; shift || return 1

 printf "%s\n" "$(expr $((`TZ=GMT0 date +"((%Y-1600)*365+(%Y-1600)/4-(%Y-1600)/100+(%Y-1600)/400+%j-135140) *86400+%H*3600+%M*60+%S"`)) - $sec)"
}
