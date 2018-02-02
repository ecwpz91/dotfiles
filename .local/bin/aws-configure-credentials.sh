aws-configure-credentials() {
 local acc=$1
 local sec=$2; shift 2 || return 1

 aws configure set aws_access_key_id "${acc:-}"
 aws configure set aws_secret_access_key "${sec:-}"
}
