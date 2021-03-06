#!/usr/bin/env bash

__DIR__="$(dirname "$("${READLINK_PATH:-readlink}" -f "$0")")"

# required libs
source "${__DIR__}/.bash/functions.shlib"

set -E
trap 'throw_exception' ERR

usage() {
cat <<EOF
Usage: ${0##*/} OPTIONS
test role

    -h          display this help and exit
    -i STRING   target host to run against (default: 127.0.0.1)
    -T          turbo mode
    -u STRING   connect as this user (default: current user)
EOF
}

OPTIND=1
while getopts "hi:Tu:" opt; do
  case "${opt}" in
    h )
      usage
      exit 0
      ;;
    i )
      TARGET_HOST="${OPTARG}"
      ;;
    T )
      TURBO_MODE=1
      ;;
    u )
      CONNECT_USER="${OPTARG}"
      ;;
    '?' )
      usage >&2
      exit 1
      ;;
  esac
done
shift "$((OPTIND-1))"

if [[ -z "${TARGET_HOST}" ]]; then
  TARGET_HOST="127.0.0.1"
  CONNECTION="local"
fi

if [[ -z "${CONNECT_USER}" ]]; then
  CONNECT_USER="$(whoami)"
fi

if [[ -z "${CONNECTION}" ]]; then
  CONNECTION="smart"
fi

role_root="$(pwd)"

if [[ -z "${TURBO_MODE}" ]]; then
  consolelog "installing requirements"
  ansible-galaxy install lifeofguenter.oracle-java
fi

consolelog "running role as playbook #1"
ansible-playbook \
  --inventory="${TARGET_HOST}," \
  --user="${CONNECT_USER}" \
  --extra-vars="role_root=${role_root}" \
  --connection="${CONNECTION}" \
  tests/test.yml

if [[ -z "${TURBO_MODE}" ]]; then
  consolelog "running role as playbook #2"
  ansible-playbook \
    --inventory="${TARGET_HOST}," \
    --user="${CONNECT_USER}" \
    --extra-vars="role_root=${role_root}" \
    --connection="${CONNECTION}" \
    tests/test.yml
fi

if [[ "${CONNECTION}" == "local" ]]; then
  sleep 10
  curl -sSI "http://${TARGET_HOST}:8080"
  echo ""
  sudo ls -lh /var/lib/jenkins/plugins/
  echo ""
  cat /var/lib/jenkins/config.xml
  echo ""
  jenkins-cli
  echo ""
  jenkins-cli who-am-i
  echo ""
  grep -F pkill /etc/init.d/jenkins
  echo ""
  grep -F 'return `ps -U $JENKINS_USER' /etc/init.d/jenkins
  echo ""
  cat /etc/default/jenkins
fi
