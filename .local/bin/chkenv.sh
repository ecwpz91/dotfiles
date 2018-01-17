chkenv() {
 local envar=$1

 if [ -n "${envar-}" ]
 then
  echo 'not empty'
elif [ "${envar+defined}" = defined ]
 then
  echo 'empty but defined'
 else
  echo 'unset'
 fi
}
