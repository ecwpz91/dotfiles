rpm-gpg-pubkey() {
 rpm --query gpg-pubkey --queryformat '%{NAME}-%{VERSION}-%{RELEASE}\t%{SUMMARY}\n'
}
