# Ansible Role: Install monit-sslcertcheck

[![Build Status](https://travis-ci.org/tschifftner/ansible-role-monit-sslcertcheck.svg)](https://travis-ci.org/tschifftner/ansible-role-monit-sslcertcheck)

Installs monit-sslcertcheck on Debian/Ubuntu linux servers.

## Requirements

None

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

### Add Monit checks
```
monit_group_services:
  - name: ssl_validate_script
    type: file
    target: /usr/local/bin/sslcertcheck.sh
    rules:
      - if failed checksum then alert
      - if failed permission 755 then alert
      - if failed uid root then alert
      - if failed gid root then alert

  - name: ssl_validate_domains
    type: file
    target: /etc/sslcertcheck.txt
    rules:
      - if failed permission 444 then alert
      - if failed uid root then alert
      - if failed gid root then alert

  - name: ssl_validate_log
    type: file
    target: /var/log/sslcertcheck.log
    rules:
      - if timestamp > 36 hours then alert

  - name: ssl_all_valid
    type: program
    target: /usr/bin/sslcertcheck-monit-helper.sh
    timeout: 300
    rules:
      - if status != 0 then alert every 1440 cycles
```

### Define domains to be checked

```
monit_sslcertcheck_domains:
  - badssl.com:443
  - expired.badssl.com:443
```

## Dependencies

None.

## Installation

```
$ ansible-galaxy install tschifftner.monit-sslcertcheck
```

## Example Playbook

    - hosts: server
      roles:
        - { role: tschifftner.monit-sslcertcheck }

## Supported OS
## Supported OS
Ansible          | Debian Jessie    | Ubuntu 14.04    | Ubuntu 12.04
:--------------: | :--------------: | :-------------: | :-------------: 
2.1              | Yes              | Yes             | Yes

## License

[MIT License](http://choosealicense.com/licenses/mit/)

## Author Information

 - [Tobias Schifftner](https://twitter.com/tschifftner), [ambimax® GmbH](https://www.ambimax.de)