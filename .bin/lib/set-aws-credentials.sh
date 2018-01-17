set-aws-credentials() {
 local fcn="${FUNCNAME[0]}"

 declare -r fcn

 usage() {
	  cat <<EOF
Usage: ${fcn:-} [ACCESS_KEY] [SECRET_KEY]
EOF
 }

 main(){
  local default_access_key=$1
  local default_secret_key=$2; shift 2 || { usage >&2; return 1; }

  aws configure set aws_access_key_id ${default_access_key:-}
  aws configure set aws_secret_access_key ${default_secret_key:-}
 }

 main "${@}"
}
