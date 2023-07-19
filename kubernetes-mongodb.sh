#!/bin/bash

USERNAME=db-username
PASSWORD=db-password
DATABASE=db-database-name
DUMP_PATH=db-dump-path
APP_NAME=db-app-name
BUCKET=db-backup-bucket

kubectl exec -i $(kubectl get pod | grep $APP_NAME | awk '{print $1}') -- mongodump --username=$USERNAME --password=$PASSWORD --authenticationDatabase=$DATABASE --out /dump/$DUMP_PATH-`date +"%m-%d-%y"` && kubectl cp $(kubectl get pod | grep $APP_NAME | awk '{print $1}'):/dump/$DUMP_PATH-`date +"%m-%d-%y"` $DUMP_PATH-`date +"%m-%d-%y"` && kubectl exec -i $(kubectl get pod | grep $APP_NAME | awk '{print $1}') -- rm -rf /dump/$DUMP_PATH-`date +"%m-%d-%y"`

echo "mongodump success"

aws s3 cp --recursive $DUMP_PATH-`date +"%m-%d-%y"` s3://$BUCKET/$DUMP_PATH/$DUMP_PATH-`date +"%m-%d-%y"`

echo "cp to bucket success"

rm -rf $DUMP_PATH-`date +"%m-%d-%y"`