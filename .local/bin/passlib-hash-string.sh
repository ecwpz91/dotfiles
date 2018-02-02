passlib-hash-string() {
 local str=$1; shift || return 1
 local cmd

 if ! python -c 'import passlib' 2>/dev/null; then
  printf "%s\n" "Passlib password hashing library missing, visit https://passlib.readthedocs.io/"; return 1
 fi

 cmd="from passlib.hash import sha512_crypt;print sha512_crypt.using(rounds=5000).hash(\"$str\")"

 python -c "$cmd"
}
