#!/usr/bin/env bash

APP=API1

DB_NAME=dvdrental
DB_USER=postgres
DB_PASS=postgres

BUCKET_NAME=postgresbackup99

TIMESTAMP=$(date +%F_%T | tr ':' '-')
TEMP_FILE=$(mktemp tmp.XXXXXXXXXX)
S3_FILE="s3://$BUCKET_NAME/$APP-backup-$TIMESTAMP"

PGPASSWORD=$DB_PASS pg_dump -Fc --no-acl -h localhost -U $DB_USER $DB_NAME > $TEMP_FILE
aws s3 cp $TEMP_FILE s3://postgresbackup99
rm "$TEMP_FILE"
