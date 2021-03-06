[![Build Status](https://travis-ci.org/NINEJKH/ansible-role-jenkins.svg?branch=master)](https://travis-ci.org/NINEJKH/ansible-role-jenkins)

# NINEJKH.jenkins

An (opinionated) Ansible role that installs Jenkins (LTS) on Debian-like systems.

It is recommended to run it on localhost and have a webserver (nginx) run in front of it, which configuration is not part of this role.

## Local test

```bash
$ ./test.sh -i 192.168.1.159 -u vbox
```

## Todos

* delete admin user if jenkins_admin_username != admin (https://stackoverflow.com/a/41255658/567193)

## Requirements

none

## Role Variables

```yaml
jenkins_http_listen_address: 127.0.0.1

jenkins_url: http://{{ jenkins_http_listen_address }}:8080

jenkins_memory_max: "{{ (ansible_memtotal_mb * 0.5) | round | int }}m"

jenkins_admin_username: admin

jenkins_admin_password: admin

jenkins_num_executors: 0

jenkins_plugins: []

jenkins_agent_port:

jenkins_java_args:
  - -server
  - -Djava.awt.headless=true
  - -Xms{{ jenkins_memory_max }}
  - -Xmx{{ jenkins_memory_max }}
  - -Djenkins.install.runSetupWizard=false
  # https://www.cloudbees.com/blog/joining-big-leagues-tuning-jenkins-gc-responsiveness-and-stability
  - -XX:+AlwaysPreTouch
  - -XX:+UseG1GC
  - -XX:+ExplicitGCInvokesConcurrent
  - -XX:+ParallelRefProcEnabled
  - -XX:+UseStringDeduplication
  - -XX:+UnlockDiagnosticVMOptions
  - -XX:G1SummarizeRSetStatsPeriod=1
```

## Dependencies

* [lifeofguenter.oracle-java](https://galaxy.ansible.com/lifeofguenter/oracle-java/)

## Example Playbook

```yaml

- hosts: jenkins
  roles:
    - { role: NINEJKH.jenkins }
```

## Acknowledgements

* [geerlingguy.jenkins](https://github.com/geerlingguy/ansible-role-jenkins)

## License

Licensed under the MIT License. See the [LICENSE file](LICENSE) for details.

## Author Information

[9JKH (Pty) Ltd.](https://9jkh.co.za)
