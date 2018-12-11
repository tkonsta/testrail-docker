#!/bin/bash -e

/etc/init.d/mysql start

# wait for the db to start
echo "Waiting for the DB to start"
until mysqladmin ping >/dev/null 2>&1; do
  echo -n "."; sleep 0.2
done

echo "Initializing DB"
echo "CREATE DATABASE testrail DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "CREATE USER 'testrail'@'localhost' IDENTIFIED BY 'newpassword';" | mysql -u root
echo "GRANT ALL ON testrail.* TO 'testrail'@'localhost';" | mysql -u root
mysql testrail < testrail.sql

echo "Stopping DB"
/etc/init.d/mysql stop

while mysqladmin ping >/dev/null 2>&1; do
  echo -n "."; sleep 0.2
done