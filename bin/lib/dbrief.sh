#!/usr/bin/env bash

# [TODO] test, prune, reset, and inspect

DOCKER=${DOCKER:-"/usr/bin/docker"}
DOCKER_INSPECT="$DOCKER inspect"
DOCKER_PS="$DOCKER ps"
DOCKER_BUILD="$DOCKER build"
DOCKER_RM="$DOCKER rm"
DOCKER_EXEC="$DOCKER exec"
DOCKER_RMI="$DOCKER rmi"
DOCKER_RMI_DANGLING="$DOCKER rmi $($DOCKER images -f "dangling=true" -q)"
DOCKER_VOLUME="$DOCKER volume"
DOCKER_STOP="$DOCKER stop"
DOCKER_IMAGES="$DOCKER images"
DOCKER_RUN="$DOCKER run"

FILTER_DANGLING='-qf dangling'
FILTER_NAME_OPTION='-f name'
FILTER_STATUS='-f status'
LIST_ALL_QUIET='-aq'
LAST_CONTAINER='-n 1'
CONTAINER_NAME='--format {{.Names}}'
CONTAINER_IP='--format {{ .NetworkSettings.IPAddress }}'

LAST_CONTAINER_NAME="$LAST_CONTAINER $CONTAINER_NAME"
DOCKER_ALL_CONTAINERS="$DOCKER_PS $LIST_ALL_QUIET"

docker-build() {
 local ctag=$1; shift || return 1

 if ! $DOCKER_BUILD -t=${ctag} . 2>/dev/null; then
  printf "fail: ${FUNCNAME[0]}: %s\n" "$DOCKER_BUILD -t=${ctag} ."
  return 1
 fi
}

dockviz() {
 docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t
}

docker-bash() {
 local name=${1:-}
 local rslt

 if [[ -z "${name}" ]]; then
  rslt="$($DOCKER_ALL_CONTAINERS $LAST_CONTAINER_NAME)"
 else
  rslt="$($DOCKER_ALL_CONTAINERS $FILTER_NAME_OPTION=${name})"
 fi

 if ! $DOCKER_EXEC -it ${rslt} bash 2>/dev/null; then
  printf "fail: ${FUNCNAME[0]}: %s\n" "$DOCKER_EXEC -it ${rslt} bash"
  return 1
 fi
}

docker-stop() {
 local name=${1:-}
 local rslt

 if [[ -z "${name}" ]]; then
  rslt=( $($DOCKER_ALL_CONTAINERS) )
 else
  rslt=( "$($DOCKER_ALL_CONTAINERS $FILTER_NAME_OPTION=${name})" )
 fi

 if ! ${#rslt[@]}; then
  for c in "${rslt[@]}"; do
   if ! $DOCKER_STOP ${c} 2>/dev/null; then
    printf "fail: ${FUNCNAME[0]}: %s\n" "$DOCKER_STOP -it ${c} bash"
    return 1
   fi
  done
 fi
}

docker-remove() {
 local name=${1:-}
 local rslt

 if [[ -z "${name}" ]]; then
  rslt=( $($DOCKER_ALL_CONTAINERS) )
 else
  rslt=( "$($DOCKER_ALL_CONTAINERS $FILTER_NAME_OPTION=${name})" )
 fi

 if ! ${#rslt[@]}; then
  for c in "${rslt[@]}"; do
   if ! $DOCKER_RM ${c} 2>/dev/null; then
    printf "fail: ${FUNCNAME[0]}: %s\n" "$DOCKER_RM -it ${c} bash"
    return 1
   fi
  done
 fi
}

docker-test() {
 docker run -d rhel /bin/bash -c 'while true; do sleep 1000; done'
}

docker-prune() {
 $DOCKER_RM "$($DOCKER_ALL_CONTAINERS $FILTER_STATUS=${1:-'exited'})" 2>/dev/null
 $DOCKER_RMI -f "$($DOCKER_IMAGES -a $FILTER_DANGLING=${1:-'true'})" 2>/dev/null
 $DOCKER_VOLUME rm "$($DOCKER_VOLUME ls $FILTER_DANGLING=${1:-'true'})" 2>/dev/null
}

docker-reset() {
 docker-stop 2>/dev/null
 docker-remove 2>/dev/null
 local rslt=( "$(docker images -q)" )

 if ! ${#rslt[@]}; then
  for i in "${rslt[@]}"; do
   if ! $DOCKER_RMI ${i} 2>/dev/null; then
    return 1
   fi
  done
 fi

 # local rslt=( "$(docker images -f "dangling=true" -q)" )
 #
 # if ! ${#rslt[@]}; then
 #  for i in "${rslt[@]}"; do
 #   if ! $DOCKER_RMI ${i} 2>/dev/null; then
 #    printf "fail: ${FUNCNAME[0]}: %s\n" "$DOCKER_RMI -it ${c} bash"
 #    return 1
 #   fi
 #  done
 # fi
}

docker-inspect() {
 local OPTIND opt maj_ver min_ver pat_ver sem_ver cmd_opts tmp_dir

 maj_ver="1"
 min_ver="0"
 pat_ver="0"
 sem_ver="$maj_ver\.$min_ver\.$pat_ver"
 func_id="${FUNCNAME[0]}"

 _usage() {
  cat << EOF
Usage: $func_id [-o OPTIONS] COMMAND
EOF
 }

 while getopts ":o:" opt; do
  case $opt in
   o  ) cmd_opts=$OPTARG ;;
   \? ) opt_ary=( "$@" ); opt_var="${opt_ary[$(($OPTIND - 2))]}"
   printf "%s\n" "$func_id: Illegal option '$opt_var'" && return 1 ;;
  esac
 done

 shift $(($OPTIND - 1))

 if [ -z "$@" ]; then
  _usage && return 1;
 fi

 for mod_name in "$@"; do

  # [TODO] add volumes
  # dkrvls() {
  #  find '/var/lib/docker/volumes/' -mindepth 1 -maxdepth 1 -type d | grep -vFf <(
  #   docker ps -aq | xargs docker inspect | jq -r '.[]|.Mounts|.[]|.Name|select(.)'
  #  );
  # }

  # [TODO] fix commnads
  case $mod_name in
   lc ) result=$($DOCKER_INSPECT "$($DOCKER_PS ${cmd_opts:-'-n 1'} 2>/dev/null)" 2>/dev/null) ;;
   * ) printf "%s\n" "$func_id: Unknown command '$mod_name'" && return 1 ;;
  esac

  if [ $? != 0 ] ; then
   printf "%s\n" "$func_id: Command failed '$result'" && return 1
  fi

  # Checks if command in hash table exists before executing it
  shopt -s checkhash

  if ! hash jq 2>/dev/null ; then
   tmp_dir=$(mktemp -d) \
   && pushd $tmp_dir &>/dev/null \
   && wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq \
   && cp -rf jq $HOME/.local/bin/jq \
   && chmod +x $HOME/.local/bin/jq \
   && popd &>/dev/null \
   && rm -rf $tmp_dir
  fi

  shopt -u checkhash

  printf "%s" "$result" | jq
 done
}

docker-mkimage() {

 usage() {
     cat <<EOOPTS
$(basename $0) [OPTIONS] <name>
OPTIONS:
   -p "<packages>"  The list of packages to install in the container.
                    The default is blank.
   -g "<groups>"    The groups of packages to install in the container.
                    The default is "Core".
   -y <yumconf>     The path to the yum config to install packages from. The
                    default is /etc/yum.conf for Centos/RHEL and /etc/dnf/dnf.conf for Fedora
EOOPTS
  exit 1
 }

 # option defaults
 yum_config=/etc/yum.conf
 if [ -f /etc/dnf/dnf.conf ] && command -v dnf &> /dev/null; then
  yum_config=/etc/dnf/dnf.conf
  alias yum=dnf
 fi
 install_groups="Core"
 while getopts ":y:p:g:h" opt; do
  case $opt in
   y)
    yum_config=$OPTARG
   ;;
   h)
    usage
   ;;
   p)
    install_packages="$OPTARG"
   ;;
   g)
    install_groups="$OPTARG"
   ;;
   \?)
    echo "Invalid option: -$OPTARG"
    usage
   ;;
  esac
 done
 shift $((OPTIND - 1))
 name=$1

 if [[ -z $name ]]; then
  usage
 fi

 target=$(mktemp -d --tmpdir $(basename $0).XXXXXX)

 set -x

 mkdir -m 755 "$target"/dev
 mknod -m 600 "$target"/dev/console c 5 1
 mknod -m 600 "$target"/dev/initctl p
 mknod -m 666 "$target"/dev/full c 1 7
 mknod -m 666 "$target"/dev/null c 1 3
 mknod -m 666 "$target"/dev/ptmx c 5 2
 mknod -m 666 "$target"/dev/random c 1 8
 mknod -m 666 "$target"/dev/tty c 5 0
 mknod -m 666 "$target"/dev/tty0 c 4 0
 mknod -m 666 "$target"/dev/urandom c 1 9
 mknod -m 666 "$target"/dev/zero c 1 5

 # amazon linux yum will fail without vars set
 if [ -d /etc/yum/vars ]; then
  mkdir -p -m 755 "$target"/etc/yum
  cp -a /etc/yum/vars "$target"/etc/yum/
 fi

 if [[ -n "$install_groups" ]];
 then
  yum -c "$yum_config" --installroot="$target" --releasever=/ --setopt=tsflags=nodocs \
  --setopt=group_package_types=mandatory -y groupinstall "$install_groups"
 fi

 if [[ -n "$install_packages" ]];
 then
  yum -c "$yum_config" --installroot="$target" --releasever=/ --setopt=tsflags=nodocs \
  --setopt=group_package_types=mandatory -y install "$install_packages"
 fi

 yum -c "$yum_config" --installroot="$target" -y clean all

cat > "$target"/etc/sysconfig/network <<EOF
NETWORKING=yes
HOSTNAME=localhost.localdomain
EOF

 # effectively: febootstrap-minimize --keep-zoneinfo --keep-rpmdb --keep-services "$target".
 #  locales
 rm -rf "$target"/usr/{{lib,share}/locale,{lib,lib64}/gconv,bin/localedef,sbin/build-locale-archive}
 #  docs and man pages
 rm -rf "$target"/usr/share/{man,doc,info,gnome/help}
 #  cracklib
 rm -rf "$target"/usr/share/cracklib
 #  i18n
 rm -rf "$target"/usr/share/i18n
 #  yum cache
 rm -rf "$target"/var/cache/yum
 mkdir -p --mode=0755 "$target"/var/cache/yum
 #  sln
 rm -rf "$target"/sbin/sln
 #  ldconfig
 rm -rf "$target"/etc/ld.so.cache "$target"/var/cache/ldconfig
 mkdir -p --mode=0755 "$target"/var/cache/ldconfig

 version=
 for file in "$target"/etc/{redhat,system}-release
 do
  if [ -r "$file" ]; then
   version="$(sed 's/^[^0-9\]*\([0-9.]\+\).*$/\1/' "$file")"
   break
  fi
 done

 if [ -z "$version" ]; then
  echo >&2 "warning: cannot autodetect OS version, using '$name' as tag"
  version=$name
 fi

 tar --numeric-owner -c -C "$target" . | docker import - $name:$version

 docker run -i -t --rm $name:$version /bin/bash -c 'echo success'

 rm -rf "$target"
}
