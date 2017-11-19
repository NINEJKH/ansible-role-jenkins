#!/usr/bin/env bash

set -e

java \
  -jar /opt/jenkins-cli/jenkins-cli.jar \
  -s 'http://{{ jenkins_http_listen_address }}:8080' \
  -auth '{{ jenkins_admin_username }}:{{ jenkins_admin_password }}' \
  "${@}"
