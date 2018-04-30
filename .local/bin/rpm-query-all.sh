rpm-query-all() {
 rpm --query --all --queryformat="%{NAME}\n" | sort -d
}
