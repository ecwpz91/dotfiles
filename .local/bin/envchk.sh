envchk() {
 local var=$1; shift || return 1
 local msg

 if [ -n "${var-}" ]; then
  msg='Not empty'
 elif [ "${var+defined}" = defined ]; then
  msg='Empty but defined'
 else
  msg='Unset'
 fi

 printf "%s\n" "$msg"
}
