#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
cd /opt/backups
file=$(date +"%Y%m%d")
mongodump -h <hostname> --port 61148 -d <database> -u <user> -p <password> --out /opt/backups/${file}
if [ "${?}" -eq 0 ]; then
  tar -cvzf ${file}.gz ${file}
  aws s3 cp ${file}.gz s3://<s3 bucketname>/
  rm /opt/backups/${file}.gz
else
  echo "Error backing"
  exit 255
fi
