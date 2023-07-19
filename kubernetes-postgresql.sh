#!/bin/bash

USERNAME=db-username
HOSTNAME=db-hostname
PASSWORD=db-password
DATABASE=db-database-name
DUMP_PATH=db-dump-path
APP_NAME=db-app-name
BUCKET=db-backup-bucket


kubectl exec -i $(kubectl get pod | grep $APP_NAME | awk '{print $1}') -- pg_dump "user=$USERNAME host=$HOSTNAME dbname=$DATABASE password=$PASSWORD" > $DUMP_PATH-`date +"%m-%d-%y"`.sql

echo "postgresql dump success"

aws s3 cp $DUMP_PATH-`date +"%m-%d-%y"`.sql s3://$BUCKET/$DUMP_PATH/$DUMP_PATH-`date +"%m-%d-%y"`.sql

echo "cp to bucket success"

rm -rf $DUMP_PATH-`date +"%m-%d-%y"`.sql