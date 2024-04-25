#!/bin/bash

# This is daily backup script

var_date=`date +%Y%m%d.%H%M`

tar czf /opt/backups/Daily-$var_date.tar.gz -P -T /etc /var/log /var/www 
