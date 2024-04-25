### DAILY WEEKLY AND MONTHLY BACKUPS

###  Table of Contents
=================

* [Introduction:](#introduction)
	* [Daily weekly and monthly backups using :](#daily-weekly-and-monthly-backups-using-)
* [Servers info:](#servers-info)
	* [Folder Structure:](#folder-structure)
* [Generating ssh key](#generating-ssh-key)
* [Backups](#backups)
	* [Daily Backups](#daily-backups)
	* [Weekly Backups](#weekly-backups)
	* [Monthly Backups](#monthly-backups)
* [Automate Using Cron Job](#automate-using-cron-job)
* [Backup Server](#backup-server)

<!-- Created by https://github.com/ekalinin/github-markdown-toc -->

 

### Introduction:

    Backup is one of the reutine activity of a system admin. In this repo there are some simple backup scripts.


#### Daily weekly and monthly backups using :
	tar         to compress and zip and unzip
	find        to find and delete the outdated backups (removes backups > 7 days on daily backup) 
	rsync       to copy and sync the backup
	cron        to automate the job


### Servers info:

	* Server to be backup [ez@mywebsite.com:~/var/www/html]
		# Server mywebsite.com or 30.x.x.x
		# user : ez
		# folder to be backup : /var/www/html

	* The Backup send to the server: [ez@myBackupserver.com:~/home/backups/mywebsite.com]
		# Server: myBackupserver.com  192.168.12.112
		# user: ez	
		# Dest folder: /home/backups/mywebsite.com


#### Folder Structure:

```bash
	mkdir /home/ez/backups
	mkdir /home/ez/backups/mywebsite.com
	mkdir /home/ez/backups/mywebsite.com/{daily,weekly,monthly}
```

### Generating ssh key
For the cron to work with out the password entry since it become automate

```bash
	# ssh-keygen -t rsa
	# ssh-copy-id ez@myBackupserver.com
```


### Backups

#### Daily Backups
    # Create backup-daily.sh script as follows 
	
* backup-daily.sh
```bash
	tar -zcf /home/ez/backups/mywebsite.com/daily/backup-$(date +%Y%m%d).tar.gz -C /var/www/html
	find /home/ez/backups/mywebsite.com/dialy/* -mtime +7 -delete
```
#### Weekly Backups
    # Create backup-weeekly.sh script as follows 
* backup-weekly.sh
```bash
	tar -zcf /home/ez/backups/mywebsite.com/weekly/backup-$(date +%Y%m%d).tar.gz -C /var/www/html
	find /home/ez/backups/mywebsite.com/weekly/* -mtime +31 -delete
```

#### Monthly Backups
    # Create backup-monthly.sh script as follows 
* backup-monthly.sh
```bash
	# tar -zcf /home/ez/backups/mywebsite.com/monthly/backup-$(date +%Y%m%d).tar.gz -C /var/www/html
	# fidn /home/ez/backups/mywebsite.com/monthly/* -mtime +365 -delete
```

### Automate Using Cron Job
	# crontab -e 
```bash
15 0 * * * sh /home/ez/backups/mywebsite.com/backup-daily.sh  # daily @ 12:15am 
30 0 * * 0 sh /home/ez/backups/mywebsite.com/backup-weekly.sh # weekly @ 12:30 every sunday
45 0 1 * * sh /home/ez/backups/mywebsite.com/backup-monthly.sh # monthly on the 1st of the month
```

### Backup Server 
	# backup is kept on other server, 
```bash
rsync -a --delete /home/ez/backups/mywebsite.com/ ez@192.168.12.112:/home/ez/backups/mywebsite
```
 	*** here we need the ssh key we copied to remote inorder to do the cron job automatically ***	
```bash
0 2 * * * rsync -a --delete /home/ez/backups/mywebsite.com/ ez@192.168.12.112:/home/ez/backups/mywebsite
```

 

