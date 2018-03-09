#!/bin/bash

function system-ansible-vault() {

 get_system_ansible() {
  local script
  local majver
  local minver
  local patver
  local tmpdir
  local ospkgs
  local osrels

  # Get Python version information
  script='import sys; print(sys.version_info[0])'
  majver=$(python -c "$script")

  script='import sys; print(sys.version_info[1])'
  minver=$(python -c "$script")

  script='import sys; print(sys.version_info[2])'
  patver=$(python -c "$script")

  if [ "${majver%.*}" -le "2" ] && [ "${minver#*.}" -le "7" ] && [ "${patver%.*}" -lt 9 ]; then
   printf "Python %s.%s.%s <2.7.9" "$majver" "$minver" "$patver" && \
    osrelv=$(rpm -q --qf '%{VERSION}' "$(rpm -q --whatprovides redhat-release)") && \
    { osrelv="${osrelv//[!6-7]}" >&2; } && \
    tmpdir=$(mktemp -d) && \
    pushd $tmpdir &>/dev/null && \
    curl -LO "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${osrelv}.noarch.rpm" && \
    rpm -Uvh "epel-release-latest-${osrelv}.noarch.rpm" --force && \
    curl -LO 'https://bootstrap.pypa.io/get-pip.py' && \
    { [[ $(yum list installed python-setuptools 2>/dev/null) ]] && yum -y upgrade python-setuptools >&2; } && \
    { [[ "${osrelv}" == '7' ]] && yum -y install python-wheel >&2; } && \
    ospkgs='python2 python-pip python-cryptography python-yaml python-simplejson ansible' && \
    yum -y install $ospkgs && \
    { [[ "${osrelv}" == '7' ]] && python get-pip.py --no-setuptools --no-wheel || python get-pip.py --no-setuptools >&2; } && \
    popd &>/dev/null && rm -rf $tmpdir && \
    pypkgs='pip cryptography pyyaml simplejson passlib passlib[bcrypt] passlib[argon2] passlib[totp] fastpbkdf2 scrypt ansible' && \
    pip install --upgrade $pypkgs
  fi
 }

 passlib_hash_string() {
  local passwd=${1:-}; shift || return 1
  local script

  if ! python -c 'import passlib' 2>/dev/null; then
   { printf "\n\%s" "Error: python module missing" >&2; return 1; };
  fi

  script="from passlib.handlers.sha2_crypt import sha512_crypt;print sha512_crypt.using(rounds=5000).hash(\"$passwd\")"

  python -c "$script"
 }

 set_system_ansible_config_vault_password_file() {
  local myfile=${1:-}
  local myconf=${2:-}; shift 2 || return 1
  local rgxstr

  if ! touch "$myconf"; then
   { printf "\n\%s" "Error: couldn't create file" >&2; return 1; };
  fi

  if ! cp "$myconf" "$myconf.${RANDOM}"; then
   { printf "\n\%s" "Error: couldn't backup file" >&2; return 1; };
  fi

  rgxstr='vault_password_file'

  if ! sed -i '/.*'"$myregx"'.*/c\vault_password_file = '"$myfile" "$myconf"; then
   printf "vault_password_file = %s" "$myfile" >> "$myconf"
  fi
 }

 main() {
  local mypass
  local chkstr

  get_system_ansible

  printf "\n\%s" "Changing password for Ansible Vault"
  printf "\n\%s" "Enter new vault password: "
  read -s mypass

  printf "\n\%s" "Retype new vault password: "
  read -s chkstr

  if [[ "$mypass" !=  "$chkstr" ]]; then
   { printf "\n\%s" "Error: passwords did not match" >&2; return 1; };
  fi

  printf "%s" "$(passlib_hash_string $mypass)" > /etc/ansible/vault

  # set_system_ansible_config_vault_password_file "/etc/ansible/vault" "/etc/ansible/ansible.cfg"
 }

 main "$@"
}
