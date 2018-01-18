#!/bin/bash
# 
# This script can be installed on an AWS EC2 instance in the crontab for the
# ubuntu user. Modify the webroot locations and the database name. Database 
# access is set in /home/ubuntu/.my.cnf

# Requirements
# Create the backups directory in /home/ubuntu/
# Create the S3 bucket to store the backups. 

cd /home/ubuntu/backups
tar zcvf $(date '+%d-%b-%Y').webroot.tar.gz /var/www/webroot
mysqldump dmarket7 > $(date '+%d-%b-%Y').database-name.sql

# Copy to the S3 bucket
aws s3 cp $(date '+%d-%b-%Y').webroot.tar.gz s3://rru-website-backups/website-url/
aws s3 cp $(date '+%d-%b-%Y').database-name.sql s3://rru-website-backups/website-url/

# Cleanup local copies
/bin/rm -rf $(date '+%d-%b-%Y').webroot.tar.gz
/bin/rm -rf $(date '+%d-%b-%Y').database-name.sql
