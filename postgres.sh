#!/usr/bin/env bash

set -e

declare -a VERSIONS=('precise' 'lucid')
VERSION_IS_SUPPORTED=false
UBUNTU_VERSION=$(lsb_release --codename | awk '{print $2}')

for VERSION in ${VERSIONS[@]}; do
  if [[ "$UBUNTU_VERSION" == "$VERSION" ]]; then
    VERSION_IS_SUPPORTED=true
  fi
done

if [[ ! $VERSION_IS_SUPPORTED ]]; then
  echo "Version '$UBUNTU_VERSION' is not supported by Postgres official repository."
  exit 1
fi

sudo bash -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ ${UBUNTU_VERSION}-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
echo "Added official Postgres apt repository for relase '${UBUNTU_VERSION}' at /etc/apt/sources.list.d/pgdg.list"

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "Added apt-key for Postgres repository."

echo "updating apt index..."
sudo apt-get update -qq
echo "OK"

# Uncomment this if you want to upgrade all the ubuntu packages
echo "upgrading the packages..."
sudo apt-get dist-upgrade -qq -y
echo "OK"

# contrib packages are for extensions like HSTORE and JSON
echo "installing postgres and libraries..."
sudo apt-get install -qq -y \
  autoconf \
  automake \
  g++ \
  gcc \
  git-core \
  libc6-dev \
  libc6-dev \
  libffi-dev \
  libffi-dev \
  libpq-dev \
  libreadline6 \
  libreadline6-dev \
  libssl-dev \
  make \
  pgadmin3 \
  postgresql-9.2 \
  postgresql-contrib-9.2 \
  zlib1g \
  zlib1g-dev
echo "OK"

sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';"
echo "Set password 'postgres' for DB USER 'postgres'"

echo "It's now possible to connect to the local database with either of the two following options:"
echo "    $ sudo -i -u postgres psql # => peer authentication, no password required"
echo "    $ psql -U postgres -h localhost # => password authentication with password 'postgres'"
