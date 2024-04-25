#!/bin/bash

# Monthly backup script


tar -zcf /home/ez/backups/mywebsite.com/monthly/backup-$(date +%Y%m%d).tar.gz -C /var/www/html

# this will delete the any backup older than 365
find /home/ez/backups/mywebsite.com/monthly/* -mtime +365 -delete
`
