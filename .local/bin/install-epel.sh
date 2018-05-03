install-epel() {
 local osrelv

 # Try enabling the Red Hat Subscription Manager (RHSM) optional and extras
 # repositories since EPEL packages may depend on packages from these
 # repositories. Otherwise use Fedora Special Interest Group (SIG) package
 if ! sudo /bin/bash -c 'subscription-manager repos --enable "rhel-*-optional-rpms" --enable "rhel-*-extras-rpms" &>/dev/null'; then

  # Get major OS release version of the installation target machine
  osrelv=$(rpm -q --qf '%{VERSION}' "$(rpm -q --whatprovides redhat-release)") \
  && { osrelv="${osrelv//[!6-7]}" >&2; }

  # Install EPEL via Fedora SIG signed binary configuration files (varying
  # by the major release number of the installation target machine)
  tmpdir=$(mktemp -d) \
  && pushd $tmpdir &>/dev/null \
  && curl -LO "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${osrelv}.noarch.rpm" \
  && sudo /bin/bash -c 'rpm -Uvh epel-release-latest-* --force' \
  && popd &>/dev/null \
  && rm -rf $tmpdir
 fi
}
