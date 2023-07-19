#!/bin/bash

USERNAME=db-username
PASSWORD=db-password
DATABASE=db-database-name
DUMP_PATH=db-dump-path
APP_NAME=db-app-name
BUCKET=db-backup-bucket


docker exec -i $(docker ps | grep $APP_NAME | awk '{print $1}') mongodump --host=$HOSTNAME --authenticationDatabase=$DATABASE --username=$USERNAME --password=$PASSWORD --out /dump/$DUMP_PATH-`date +"%m-%d-%y"` && docker cp $(docker ps | grep $APP_NAME | awk '{print $1}'):/dump/$DUMP_PATH-`date +"%m-%d-%y"` $DUMP_PATH-`date +"%m-%d-%y"` && docker exec -i $(docker ps | grep $APP_NAME | awk '{print $1}') rm -rf /dump/$DUMP_PATH-`date +"%m-%d-%y"`

echo "mongodump success"

aws s3 cp --recursive $DUMP_PATH-`date +"%m-%d-%y"` s3://$BUCKET/$DUMP_PATH/$DUMP_PATH-`date +"%m-%d-%y"`

echo "cp to bucket success"

rm -rf $DUMP_PATH-`date +"%m-%d-%y"`
