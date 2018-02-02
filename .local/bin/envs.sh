envs() {
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
 THIS_ABSOLUTE_PATH="$(absolute_path "${THIS_PATH}")"

 printf "THIS_PATH \xE2\x9E\xA1 %s\n" "${THIS_PATH}"
 printf "THIS_DIRS \xE2\x9E\xA1 %s\n" "${THIS_DIRS}"
 printf "THIS_FILE \xE2\x9E\xA1 %s\n" "${THIS_FILE}"
 printf "THIS_NAME \xE2\x9E\xA1 %s\n" "${THIS_NAME}"
 printf "THIS_TYPE \xE2\x9E\xA1 %s\n" "${THIS_TYPE}"
 printf "THIS_RELATIVE_PATH \xE2\x9E\xA1 %s\n" "${THIS_RELATIVE_PATH}"

 pushd "${THIS_RELATIVE_PATH}" &>/dev/null

 if [ -h "$( pwd )" ]; then
  THIS_ABSOLUTE_PATH="$( readlink ${THIS_RELATIVE_PATH} )"
 else
  THIS_ABSOLUTE_PATH="${THIS_RELATIVE_PATH}"
 fi

 popd &>/dev/null

 printf "THIS_ABSOLUTE_PATH \xE2\x9E\xA1 %s\n" "${THIS_ABSOLUTE_PATH}"
}
