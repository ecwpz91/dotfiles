#!/usr/bin/env bash

# Stop script on NZEC
# set -e

# Stop script if unbound variable found (use ${var:-} if intentional)
# set -u

# By default cmd1 | cmd2 returns exit code of cmd2 regardless of cmd1 success
# this is causing it to fail
# set -o pipefail

# Checks if command in hash table exists before executing it
shopt -s checkhash

START_TIME=$(date +%s)
SCRIPT_NAME=$(basename "$0")
__PLATFORM='unknown'
__MACHBITS='unknown'
__BASHPROF='unknown'
__UNAMESTR="$(uname)"
__MACHARCH="$(uname -m)"

function exit_trap() {
 local return_code=$?

 END_TIME=$(date +%s)

 if [[ "${return_code}" -eq "0" ]]; then
  verb="succeeded"
 else
  verb="failed"
 fi

 echo "$0 ${verb} after $((${END_TIME} - ${START_TIME})) seconds"
 exit "${return_code}"
}
trap exit_trap EXIT

function get_absolute_path() {
 local relative_path="$1"
 local get_absolute_path

 pushd "${relative_path}" >/dev/null
 relative_path="$( pwd )"
 if [[ -h "${relative_path}" ]]; then
  get_absolute_path="$( readlink "${relative_path}" )"
 else
  get_absolute_path="${relative_path}"
 fi
 popd >/dev/null

 echo "${get_absolute_path}"
}

function load_library() {
 local library=$1; shift || return 1
 local notfile=$1; shift || return 1
 local library_files

 # Concatenate library files
 library_files=( $( find "${library}" -type f -name '*.sh' -not -path "*${library}/${notfile}" ) )

 # Load libraries into current shell
 for library_file in "${library_files[@]}"; do
  source "${library_file}"
  libstr="${library_file##*\/}"
  # printf "load_library: %s\n" "${libstr%.*}"
 done

 unset library_files library_file
}

# Verify supported system
if [[ "$__UNAMESTR" == "Linux" ]]; then
 __PLATFORM="Linux"
 __BASHPROF=".bashrc"
elif [[ "$__UNAMESTR" == "Darwin" ]]; then
 __PLATFORM="macOS"
 __BASHPROF=".bash_profile"
fi

if [[ "${__PLATFORM}" == "unknown" || "${__BASHPROF}" == "unknown" ]]; then
 echo "Unknown platform: script should exit" && exit 1
fi

if [[ "${__MACHARCH}" == "x86_64" ]]; then
 __MACHBITS="64bit"
fi

if [[ "$__MACHBITS" == "unknown" ]]; then
 echo "Unsupported architecture: stoping script" && exit 1
fi
# Resolve $SOURCE until the file is no longer a symlink
SOURCE="`test -L ${BASH_SOURCE[0]} \
&& readlink ${BASH_SOURCE[0]} \
|| echo ${BASH_SOURCE[0]}`"

while [ -h "$SOURCE" ]; do
 DIRPATH="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
 SOURCE="$(readlink "$SOURCE")"

 # If $SOURCE was a relative symlink, we need to resolve it relative to the path
 # where the symlink file was located.
 [[ $SOURCE != /* ]] && SOURCE="$DIRPATH/$SOURCE"
done

DIRPATH="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
FILESRC="${SOURCE##*\/}"
ABSPATH="$(get_absolute_path "$DIRPATH/..")"
PROJECT="${PROJECT:-"${ABSPATH##*/}"}"

[ ${DEBUG:-} ] && cat <<EOF
${PROJECT}
${FILESRC}
${DIRPATH}
${ABSPATH}
EOF

# Helpers
# load_library "${PROJECT:-}"

# Install libvirt and qemu-kvm
sudo yum install libvirt qemu-kvm -y

# Add yourself to the libvirt group so that you do not need to sudo
printf "%s " "root@${HOSTNAME}"; su - root -c 'newgrp libvirt
                                         usermod -a -G libvirt ${USER}
                                         systemctl start libvirtd
                                         systemctl enable libvirtd
                                         curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm -o /usr/local/bin/docker-machine-driver-kvm
                                         chmod +x /usr/local/bin/docker-machine-driver-kvm
'

# Check if Docker machine exists, if not install locally
# sudo curl -L https://github.com/docker/machine/releases/download/v0.10.0/docker-machine-`uname -s`-`uname -m` -o /usr/local/bin/docker-machine \
# && sudo chmod +x /usr/local/bin/docker-machine-driver-kvm

# Check if oc exists, if not install locally

curl -L -O 'https://mirror.openshift.com/pub/openshift-v3/clients/3.6.173.0.21/linux/oc.tar.gz' | tar -xvzf - -C $HOME/.local/bin --strip 1 \
&& chmod +x $HOME/.local/bin/oc \
&& rm -rf $HOME/.local/bin/oc.sh &>/dev/null \
&& oc completion bash > $HOME/.local/bin/oc.sh

# Check if minishift exists, if not install locally
MINISHIFT_BINARY="$HOME/Downloads/cdk-3.2.0-1-minishift*" \
&& [ -f $MINISHIFT_BINARY ] \
&& mv $MINISHIFT_BINARY $HOME/.local/bin/minishift \
&& chmod +x $HOME/.local/bin/minishift

[ ! -d $HOME/.minishift ] \
&& minishift setup-cdk \
&& minishift config set memory 4096 &>/dev/null \
&& minishift config set cpus 2  &>/dev/null

function get_export() {
 cat <<EOF
# ----------------------------------------------------------------------
# Minishift
# ----------------------------------------------------------------------
# export MINISHIFT_VM_DRIVER=
# export MINISHIFT_USERNAME=
# export MINISHIFT_PASSWORD=

EOF
}

echo "$(get_export)" >> $HOME/.bashrc
