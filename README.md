### DAILY WEEKLY AND MONTHLY BACKUPS
# Daily weekly and monthly backups using :
	# tar : to compress and zip and unzip
	# find : to find and delete the outdated backups (removes backups > 7 days on daily backup) 
	# rsync : to copy and sync the backup
	# cron : to automate the job

# The servers info:
	# Server to be back up [ez@mywebsite.com:~/var/www/html]
		# Server mywebsite.com or 3.230.84.161
		# user : ez
		# folder to be backup : /var/www/html
	# The Backup send to the server: [ez@myBackupserver.com:~/home/backups/mywebsite.com]
		# Server: myBackupserver.com  192.168.12.112
		# user: ez	
		# Dest folder: /home/backups/mywebsite.com



### Creating the folders on the dest backup servers:
	mkdir /home/ez/backups
	mkdir /home/ez/backups/mywebsite.com
	mkdir /home/ez/backups/mywebsite.com/{daily,weekly,monthly}

### For the cron to work with out the password entry since it become automate
	# ssh-keygen -t rsa
	# ssh-copy-id ez@myBackupserver.com

### DAILY BACKUPS
    # Create backup-daily.sh script as follows 
	`backup-daily.sh
	# tar -zcf /home/ez/backups/mywebsite.com/daily/backup-$(date +%Y%m%d).tar.gz -C /var/www/html
	# find /home/ez/backups/mywebsite.com/dialy/* -mtime +7 -delete
	`
### WEEKLY BACKUPS
    # Create backup-weeekly.sh script as follows 
	`backup-weekly.sh
	# tar -zcf /home/ez/backups/mywebsite.com/weekly/backup-$(date +%Y%m%d).tar.gz -C /var/www/html
	# find /home/ez/backups/mywebsite.com/weekly/* -mtime +31 -delete
	`

### MONTHLY BACKUPS
    # Create backup-monthly.sh script as follows 
	`backup-monthly.sh
	# tar -zcf /home/ez/backups/mywebsite.com/monthly/backup-$(date +%Y%m%d).tar.gz -C /var/www/html
	# fidn /home/ez/backups/mywebsite.com/monthly/* -mtime +365 -delete
	`

### AUTOMATE WITH CRON
	# crontab -e 
		15 0 * * * sh /home/ez/backups/mywebsite.com/backup-daily.sh  # daily @ 12:15am 
		30 0 * * 0 sh /home/ez/backups/mywebsite.com/backup-weekly.sh # weekly @ 12:30 every sunday
		45 0 1 * * sh /home/ez/backups/mywebsite.com/backup-monthly.sh # monthly on the 1st of the month
		


### BACKUP EXTERNALLY
	# backup is kept on other server incase of any disaster inorder to recover it from the other server 
	# rsync -a --delete /home/ez/backups/mywebsite.com/ ez@192.168.12.112:/home/ez/backups/mywebsite

 	*** here we need the ssh key we copied to remote inorder to do the cron job automatically ***	
	# 0 2 * * * rsync -a --delete /home/ez/backups/mywebsite.com/ ez@192.168.12.112:/home/ez/backups/mywebsite


### 

