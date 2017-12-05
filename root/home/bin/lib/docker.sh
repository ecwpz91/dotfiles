#!/usr/bin/env bash

# [TODO] test, prune, reset, and inspect

DOCKER=${DOCKER:-"/usr/bin/docker"}
DOCKER_INSPECT="$DOCKER inspect"
DOCKER_PS="$DOCKER ps"
DOCKER_BUILD="$DOCKER build"
DOCKER_RM="$DOCKER rm"
DOCKER_EXEC="$DOCKER exec"
DOCKER_RMI="$DOCKER rmi"
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

 for c in "${rslt[@]}"; do
  if ! $DOCKER_STOP ${c} 2>/dev/null; then
   printf "fail: ${FUNCNAME[0]}: %s\n" "$DOCKER_STOP -it ${c} bash"
   return 1
  fi
 done
}

docker-test() {
 docker run -d rhel /bin/bash -c 'while true; do sleep 1000; done'
}

docker-prune() {
 $DOCKER_RM $($DOCKER_ALL_CONTAINERS $FILTER_STATUS=${1:-'exited'})
 $DOCKER_RMI -f $($DOCKER_IMAGES -a $FILTER_DANGLING=${1:-'true'})
 $DOCKER_VOLUME rm $($DOCKER_VOLUME ls $FILTER_DANGLING=${1:-'true'})
}

docker-reset() {
 docker-stop-all &>/dev/null
 $DOCKER_RM $($DOCKER_ALL_CONTAINERS)
 $DOCKER_RMI -f $($DOCKER_IMAGES -q)
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
