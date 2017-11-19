[![Build Status](https://travis-ci.org/NINEJKH/ansible-role-jenkins.svg?branch=master)](https://travis-ci.org/NINEJKH/ansible-role-jenkins)

# NINEJKH.jenkins

An Ansible role that installs Jenkins (LTS) on Debian-like systems.

## Requirements

none

## Role Variables

none

## Dependencies

* [lifeofguenter.oracle-java](https://galaxy.ansible.com/lifeofguenter/oracle-java/)

## Example Playbook

```yaml

- hosts: jenkins
  roles:
    - { role: NINEJKH.jenkins }
```

## License

Licensed under the MIT License. See the [LICENSE file](LICENSE) for details.

## Author Information

[9JKH (Pty) Ltd.](https://9jkh.co.za)
