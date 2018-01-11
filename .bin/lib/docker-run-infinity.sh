docker-run-infinity() {
 local name=${1:-}; shift || return 1

 docker run -d ${name:-} /bin/bash -c 'while true; do sleep 1000; done'
}
