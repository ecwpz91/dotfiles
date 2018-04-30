install-epel() {
 local osrelv

 osrelv=$(rpm -q --qf '%{VERSION}' "$(rpm -q --whatprovides redhat-release)") \
 && { osrelv="${osrelv//[!6-7]}" >&2; } \
 && pushd $tmpdir &>/dev/null \
 && curl -LO "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${osrelv}.noarch.rpm" \
 && rpm -Uvh "epel-release-latest-${osrelv}.noarch.rpm" --force \
 && popd &>/dev/null && rm -rf $tmpdir
}
