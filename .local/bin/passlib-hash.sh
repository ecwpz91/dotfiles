function passlib-hash() {
 local passwd=$1; shift || return 1
 local script

 if ! python -c 'import passlib' 2>/dev/null; then
  printf "%s\n" "Passlib password hashing library missing, visit https://passlib.readthedocs.io/"; return 1
 fi

 script="from passlib.hash import sha512_crypt;print sha512_crypt.using(rounds=5000).hash(\"$passwd\")"

 python -c "$script"
}
