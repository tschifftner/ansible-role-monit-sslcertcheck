#!/usr/bin/env bash
if [ ! -f /var/log/ssl_cert_check.log ]; then
    echo 'log file missing'
    exit 1
fi

result=$(/bin/grep ':Expiring\|:Expired' /var/log/ssl_cert_check.log)
echo $result;

# if empty, everything is ok. Otherwise there are expired certifications
[[ $result == '' ]] && exit 0 || exit 1