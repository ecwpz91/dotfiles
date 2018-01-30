source-library-files() {
 local fcn="${FUNCNAME[0]}"

 usage() {
	  cat <<EOF
Usage: ${FCN:-} [LIBPATH] [FILEEXT]
EOF
 }

 main() {
  local libpath=$1; shift || usage >&2; return 1
  local fileext=$1; shift || usage >&2; return 1
  local fileids="$(test -L ${BASH_SOURCE[0]} && readlink ${BASH_SOURCE[0]} || echo ${BASH_SOURCE[0]})"

  # [TODO] Parameterize NOT path using fileids, shorten variable names, and test

  printf "%s\n" "$fileids"

  # local library_files
  #
  # # Concatenate library files
  # library_files=( $( find "${library}" -type f -name '*.sh' -not -path "*${library}/init.sh" ) )
  #
  # # Load libraries into current shell
  # for library_file in "${library_files[@]}"; do
  #  source "${library_file}"
  #  libstr="${library_file##*\/}"
  #  # printf "load_library: %s\n" "${libstr%.*}"
  # done
  #
  # unset library_files library_file

 }
}
