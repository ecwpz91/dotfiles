#!/bin/bash

function system-ansible-vault() {

 get_system_ansible() {
  local script
  local majver
  local minver
  local patver
  local tmpdir
  local osrelv

  # Get Python version information
  script='import sys; print(sys.version_info[0])'
  majver=$(python -c "$script")

  script='import sys; print(sys.version_info[1])'
  minver=$(python -c "$script")

  script='import sys; print(sys.version_info[2])'
  patver=$(python -c "$script")

  if [ "${majver%.*}" -le "2" ] && [ "${minver#*.}" -le "7" ] && [ "${patver%.*}" -lt 9 ]; then
   printf "Python %s.%s.%s <2.7.9\n" "$majver" "$minver" "$patver" \
   && osrelv=$(rpm -q --qf '%{VERSION}' "$(rpm -q --whatprovides redhat-release)") \
   && { osrelv="${osrelv//[!6-7]}" >&2; } \
   && tmpdir=$(mktemp -d) \
   && pushd $tmpdir &>/dev/null \
   && curl -LO "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${osrelv}.noarch.rpm" \
   && rpm -Uvh "epel-release-latest-${osrelv}.noarch.rpm" --force \
   && { [[ $(yum list installed python-pip 2>/dev/null) ]] && yum -y remove python-pip >&2; } \
   && { [[ $(yum list installed python-setuptools 2>/dev/null) ]] && yum -y upgrade python-setuptools >&2; } \
   && { [[ "${osrelv}" == '7' ]] && yum -y install python-setuptools python-wheel >&2; } && \
   # Uncomment next two lines to install pip with get-pip.py:
   # curl -LO 'https://bootstrap.pypa.io/get-pip.py' && \
   # { [[ "${osrelv}" == '7' ]] && python get-pip.py --no-setuptools --no-wheel || python get-pip.py --no-setuptools >&2; } && \
   yum -y install python-pip python-cryptography python-passlib ansible && \
   # [NOTE]: Be cautious if you're using a Python install that's managed by your operating
   # system or another package manager. get-pip.py does not coordinate with those tools,
   # and may leave your system in an inconsistent state.
   pip install --upgrade pip cryptography passlib ansible \
   && popd &>/dev/null \
   && rm -rf $tmpdir \
   && source /etc/environment \
   && source /etc/profile
  fi
 }

 passlib_hash_string() {
  local passwd=${1:-}; shift || return 1
  local script

  script='import passlib'

  if ! python -c "$script" &>/dev/null; then
   printf "%s\n" "Error: not a valid python module" \
   && return 1
   # See https://passlib.readthedocs.io/en/stable/install.html#installation-instructions
  fi

  script="from passlib.hash import sha512_crypt;print sha512_crypt.using(rounds=5000).hash(\"$passwd\")"

  python -c "$script"
 }

 get_system_ansible_vault_password() {
  local mypass
  local chkstr

  printf "\%s\n" "Changing password for Ansible Vault"
  printf "\%s" "Enter new vault password:"
  read mypass

  printf "\%s" "Retype new vault password:"
  read chkstr

  if [[ "${mypass}" !=  "${chkstr}" ]]; then
   printf "%s\n" "Error: passwords did not match" \
   && return 1
  fi

  printf "%s" "$(passlib_hash_string $mypass)"
 }

 set_system_ansible_config_vault_password_file() {
  local myfile=${1:-}
  local myconf=${2:-}; shift 2 || return 1
  local bakext
  local rgxstr

  if ! touch "$myconf"; then
   printf "%s\n" "Error: couldn't create file" \
   && return 1
  fi

  bakext="$((`date +((%Y-1600)*365+(%Y-1600)/4-(%Y-1600)/100+(%Y-1600)/400+%j-135140)*86400+%H*3600+%M*60+%S`))"

  if ! cp "$myconf" "$myconf.$backup"; then
   printf "%s\n" "Error: couldn't backup file" \
   && return 1
  fi

  rgxstr='vault_password_file'

  if ! sed -i '/.*'"$myregx"'.*/c\vault_password_file = '"$myfile" "$myconf"; then
   printf "vault_password_file = %s" "$myfile" >> "$myconf"
  fi
 }

 main() {
  local vaultf
  local syscfg

  vaultf='/etc/ansible/vault'
  syscfg='/etc/ansible/ansible.cfg'

  get_system_ansible
  printf "%s" "$(get_system_ansible_vault_password)" > "$vaultf"
  set_system_ansible_config_vault_password_file "$vaultf" "$syscfg"
 }

 main "$@"
}
