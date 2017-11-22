#!/usr/bin/env bash

set -e

java \
  -jar /opt/jenkins-cli/jenkins-cli.jar \
  -s '{{ jenkins_url }}' \
  -auth '{{ jenkins_admin_username }}:{{ jenkins_admin_password }}' \
  "${@}"
