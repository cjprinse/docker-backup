#!/bin/sh

dockerize -template /tmp/config/ssmtp/ssmtp.conf.tmpl:/etc/ssmtp/ssmtp.conf

rm -rf /tmp/config
