#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
cd /opt/backups
file=$(date +"%Y%m%d")
mongodump -h ds161148.mlab.com --port 61148 -d loyalty-studios -u backup_loyaltyprod -p G2X3Q7xwsdcvCtXkl8q --out /opt/backups/${file}
if [ "${?}" -eq 0 ]; then
  tar -cvzf ${file}.gz ${file}
  aws s3 cp ${file}.gz s3://backup-loyaltyproduction/
  rm /opt/backups/${file}.gz
else
  echo "Error backing"
  exit 255
fi
