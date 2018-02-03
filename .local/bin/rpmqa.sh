rpmqa() {
 rpm -qa --queryformat="%{NAME}\n" | sort -d
}
