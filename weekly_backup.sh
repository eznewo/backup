#!/bin/bash

# This is Weekly backup script

var_date=`date +%Y%m%d.%H%M`

tar czf /opt/backups/Weekly-$var_date.tar.gz -P -T /etc /var/log /var/www 
