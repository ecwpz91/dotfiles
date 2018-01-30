rpm-gpg-pubkey() {
 # See https://linuxconfig.org/how-to-list-import-and-remove-archive-signing-keys-on-centos-7
 rpm -q gpg-pubkey --qf '%{NAME}-%{VERSION}-%{RELEASE}\t%{SUMMARY}\n'
}
