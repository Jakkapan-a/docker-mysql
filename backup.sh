#! /bin/bash


# MySQL database credentials

DB_HOST="host.docker.internal"
DB_PORT="3309"

DB_USER="root"
DB_PASS="root"
DB_NAME="db_name"

BACKUP_DIR="./data/mysql_backup"
DATE=$(date +"%Y-%m-%d")
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"

# Create the backup directory
if [ ! -d $BACKUP_DIR ]; then
  mkdir -p $BACKUP_DIR
fi

# Backup the database
mysqldump -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_FILE

# Compress the backup file
gzip $BACKUP_FILE

# Delete backups older than 30 days
find $BACKUP_DIR -type f -name "*.gz" -mtime +7 -delete

# Show the backup directory
ls -lh $BACKUP_DIR

echo "Backup completed:" $BACKUP_FILE.gz