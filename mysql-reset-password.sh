#!/usr/bin/env bash

set -e

kill_all_mysql_related () {
  # [[ $(pgrep mysqld) ]] && sudo service mysql stop
  for PID in $(pgrep mysqld_safe); do sudo kill -9 "$PID"; done
  for PID in $(pgrep mysqld); do sudo kill -9 "$PID"; done
}

kill_all_mysql_related

sudo mysqld_safe --skip-grant-tables --skip-networking

echo "UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root';" > mysql-auth-script.sql
echo "FLUSH PRIVILEGES" >> mysql-auth-script.sql

mysql -uroot < mysql-auth-script.sql

echo "here"

sleep 1

kill_all_mysql_related

echo "killed"

# sudo service mysql restart
