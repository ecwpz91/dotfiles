install-pip() {
 local script
 local majver
 local minver
 local patver
 local tmpdir
 local osrelv

 script='import sys; print(sys.version_info[0])'
 majver=$(python -c "$script")

 script='import sys; print(sys.version_info[1])'
 minver=$(python -c "$script")

 script='import sys; print(sys.version_info[2])'
 patver=$(python -c "$script")

 if ! type pip &>/dev/null; then
  if [ "${majver%.*}" -le "2" ] && [ "${minver#*.}" -le "7" ] && [ "${patver%.*}" -lt 9 ]; then
   printf "Python %s.%s.%s <2.7.9" "$majver" "$minver" "$patver" \
   && osrelv=$(rpm -q --qf '%{VERSION}' "$(rpm -q --whatprovides redhat-release)") \
   && { osrelv="${osrelv//[!6-7]}" >&2; } \
   && tmpdir=$(mktemp -d) \
   && pushd $tmpdir &>/dev/null \
   && curl -LO "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${osrelv}.noarch.rpm" \
   && rpm -Uvh "epel-release-latest-${osrelv}.noarch.rpm" --force \
   && curl -LO 'https://bootstrap.pypa.io/get-pip.py' \
   && { [[ $(yum list installed python-setuptools 2>/dev/null) ]] && yum -y upgrade python-setuptools >&2; } \
   && { [[ "${osrelv}" == '7' ]] && yum -y install python-wheel >&2; } \
   && yum -y install python-pip \
   && { [[ "${osrelv}" == '7' ]] && python get-pip.py --no-setuptools --no-wheel || python get-pip.py --no-setuptools >&2; } \
   && popd &>/dev/null && rm -rf $tmpdir
  fi
 fi

 pip install --upgrade --user pip
}
