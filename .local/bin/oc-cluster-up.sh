oc-cluster-up() {
 oc cluster up --public-hostname "${1:-127.0.0.1}.xip.io" --routing-suffix "${1:-127.0.0.1}.xip.io"
}
