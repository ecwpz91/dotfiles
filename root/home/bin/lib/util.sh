#!/usr/bin/env bash

shopt -s checkhash # Checks if command in hash table exists before executing it

function passlib-encrypt() {
 local string=$1; shift || return 1
 local script

 script="from passlib.hash import sha512_crypt;print sha512_crypt.using(rounds=5000).hash(\"$string\")"

 python -c "$script"
}

function unzip-strip() {
 local zip=$1
 local dest=${2:-.}
 local temp

 temp=$(mktemp -d) && unzip -d "$temp" "$zip" && mkdir -p "$dest" &&
 shopt -s dotglob && local f=("$temp"/*) \
 && if (( ${#f[@]} == 1 )) && [[ -d "${f[0]}" ]]; then
  mv "$temp"/*/* "$dest"
 else
  mv "$temp"/* "$dest"
 fi \
 && rmdir "$temp"/* "$temp" \
 && shopt -u dotglob
}

function env-var-exists() {
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

function diff-epoch-sec() {
 local fromtime=$1; shift || return 1
 local currtime
 currtime=$(date +%s)

 echo "$(expr $currtime - $fromtime)"
}

function command-exists() {
 local mycomm=$1; shift || return 1

 hash $mycomm 2>/dev/null || return 1
}

function this-file() {
 echo "$(basename "`test -L ${BASH_SOURCE[0]} \
 && readlink ${BASH_SOURCE[0]} \
 || echo ${BASH_SOURCE[0]}`")"

 echo "** Source **"
 THIS_PATH="${BASH_SOURCE[0]}"
 THIS_DIRS="$( cd "`dirname "${THIS_PATH}"`" && pwd )"
 THIS_FILE="${THIS_PATH##*\/}"
 THIS_NAME="${THIS_FILE%.*}"
 THIS_TYPE="${THIS_FILE##*\.}"
 THIS_RELATIVE_PATH="$( cd "`dirname "${THIS_PATH}"`" && pwd )/${THIS_FILE}"
 THIS_ABSOLUTE_PATH="$(_absolute_path "${THIS_PATH}")"

 printf "THIS_PATH \xE2\x9E\xA1 %s\n" "${THIS_PATH}"
 printf "THIS_DIRS \xE2\x9E\xA1 %s\n" "${THIS_DIRS}"
 printf "THIS_FILE \xE2\x9E\xA1 %s\n" "${THIS_FILE}"
 printf "THIS_NAME \xE2\x9E\xA1 %s\n" "${THIS_NAME}"
 printf "THIS_TYPE \xE2\x9E\xA1 %s\n" "${THIS_TYPE}"
 printf "THIS_RELATIVE_PATH \xE2\x9E\xA1 %s\n" "${THIS_RELATIVE_PATH}"
 printf "THIS_ABSOLUTE_PATH \xE2\x9E\xA1 %s\n" "${THIS_ABSOLUTE_PATH}"
}

# Show all alias related docker
show-aliases() {
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
