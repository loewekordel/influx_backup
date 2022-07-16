#!/usr/bin/env bash

TIMESTAMP="$(date +"%Y-%m-%d_%H%M")"
BACKUP_TAR="influxdb_backup_$TIMESTAMP.tar"
IOTSTACK="/home/pi/IOTstack"
BACKUPS="$IOTSTACK/backups"
INFLUXBACKUP="$BACKUPS/influxdb"
INFLUXBACKUPDB="$INFLUXBACKUP/db"

echo "Create INFLUX DB backup"

echo "Remove old influx db backup"
sudo rm -rfv "$INFLUXBACKUPDB"/*
sudo rm -v *.tar

# create influx db backup
echo "Create influx db portable backup"
docker exec influxdb influxd backup -portable /var/lib/influxdb/backup

# sweep the backup into a tar (sudo is needed because backup files are
# created with owner root, group root, mode 600)
echo "Create backup tar"
sudo tar \
	-cvf "$BACKUP_TAR" \
	-C "$INFLUXBACKUPDB" \
	.

# report size of archive
du -h "$BACKUP_TAR"

echo "INFLUX DB backup finished"











































