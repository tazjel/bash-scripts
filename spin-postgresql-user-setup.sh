#!/usr/bin/env bash

set -e

echo
echo "--- Setting up PostgreSQL for 'spin' project ---"
echo

sudo -iu postgres psql -c "DROP DATABASE IF EXISTS spin_development;"
echo "Drop 'spin_development' database."
echo

sudo -iu postgres psql -c "DROP DATABASE IF EXISTS spin_test;"
echo "Drop 'spin_test' database."
echo

if [[ $(sudo -iu postgres psql postgres -c "SELECT rolname FROM pg_roles WHERE rolname='spin';" | grep spin) ]]; then
  sudo -iu postgres psql -c "DROP USER spin;"
  echo "Drop 'spin' postgresql user."
else
  echo "PostgreSQL user 'spin' does not exist, not dropping."
fi
echo

sudo -iu postgres psql -c "CREATE USER spin WITH SUPERUSER PASSWORD 'spin';"
echo "Create 'spin' postgresql user as superuser with password 'spin'."
echo

sudo -iu postgres psql -c "CREATE DATABASE spin_development WITH OWNER spin;"
echo "Create 'spin_development' database with owner 'spin'."
echo

sudo -iu postgres psql -c "CREATE DATABASE spin_test WITH OWNER spin;"
echo "Create 'spin_test' database with owner 'spin'."
echo
# sudo -u spin psql -c "GRANT ALL PRIVILEGES ON DATABASE spin_development TO spin;"
# sudo -u spin psql -c "GRANT ALL PRIVILEGES ON DATABASE spin_test TO spin;"
# sudo -u spin psql -c "ALTER DATABASE spin_development OWNER TO spin;"
# sudo -u spin psql -c "ALTER DATABASE spin_test OWNER TO spin;"
