#!/bin/bash


# MySQL database credentials

DB_HOST="host.docker.internal"
DB_PORT="3309"

DB_USER="root"
DB_PASS="root"
DB_NAME="db_name"

BACKUP_DIR="./data/mysql_backup"
DATE=$(date +"%Y-%m-%d")

# Restore the database
gunzip < $BACKUP_DIR/$DB_NAME-$DATE.sql.gz | mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME

echo "Restore completed:" $BACKUP_DIR/$DB_NAME-$DATE.sql