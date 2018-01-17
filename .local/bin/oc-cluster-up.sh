oc-cluster-up() {
 local ipaddr=${1:-127.0.0.1}

 oc cluster up --public-hostname $ipaddr.xip.io --routing-suffix $ipaddr.xip.io
}
