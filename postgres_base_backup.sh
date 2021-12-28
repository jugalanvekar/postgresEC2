#!/usr/bin/env bash

APP=API1

DB_NAME=dvdrental
DB_USER=postgres
DB_PASS=postgres

BUCKET_NAME=postgresbackup999

TIMESTAMP=$(date +%F_%T | tr ':' '-')
TEMP_FILE=$(date +"%d-%m-%Y")
S3_FILE="s3://$BUCKET_NAME/$APP-backup-$TIMESTAMP"

#mkdir -p /mys3bucket/backups2/postgres_basebkp
#PGPASSWORD=$DB_PASS pg_dump -Fc --no-acl -h localhost -U $DB_USER $DB_NAME > $TEMP_FILE
pg_basebackup -h localhost -p 5432 -U postgres -D /mys3bucket/backups2/$TEMP_FILE  -Ft -z -Xs -P
aws s3 cp /mys3bucket/backups2 s3://postgresbackup999 --recursive
rm -rf /mys3bucket/backups2/postgres_basebkp