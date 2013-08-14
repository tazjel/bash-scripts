#!/usr/bin/env bash

#################
# SHELL OPTIONS #
#################

# always expand the glob pattern (in ls and cd commands for example)
shopt -s globstar
# enable the inverse detection, for example ls !(b*)
shopt -s extglob

# To be called like:
# if $(is_in_path $HOME/bbin); then echo YES; else echo NO; fi # => NO
# if $(is_in_path $HOME/bin); then echo YES; else echo NO; fi # => YES
is_in_path () {
  local TARGET=$1

  if [[ $(echo $PATH | grep "\(^\|:\)$TARGET\(:\|\$\)") ]]; then
    return 0
  else
    return 1
  fi
}

gsettings_set () {
  local SCHEMA=$1
  local KEY=$2
  local VALUE=$3

  gsettings set "$SCHEMA" "$KEY" "$VALUE"
  echo "gsettings set $SCHEMA $KEY $VALUE"
}

download_if_missing () {
  local URL=$1
  local FILENAME=$(basename $URL)
  local DOWNLOAD_DIR="$HOME/Downloads"

  mkdir -p "$DOWNLOAD_DIR"

  if [[ -f "$DOWNLOAD_DIR/$FILENAME" ]]; then
    echo "$FILENAME has already been downloaded"
  else
    wget -P "$DOWNLOAD_DIR" "$URL"
  fi
}

add_ppa_if_missing () {
  local PPA=$1
  # The source filename is created from the name of the repository...
  # - removing trailing "ppa:"
  # - replacing '/' with '-'
  # - replacing '.' with '_'
  # - appending the version codename (precise, for example)
  local SOURCE_FILENAME=$(echo $PPA | sed 's/^ppa://g' | sed 's/\//-/g' | sed 's/\./_/g')
  # The * is there in order to avoid to specify the version codename.
  # The SOURCE_FILEPATH will return null if the file pattern does not exist.
  local SOURCE_FILEPATH=$(find /etc/apt/sources.list.d/ -iname "${SOURCE_FILENAME}*.list")
  # Find the size only if the file exists, or return null.
  local SOURCE_FILE_SIZE=$([[ -n "$SOURCE_FILEPATH" ]] && ls -l $SOURCE_FILEPATH | awk '{ print $5 }')

  if [[ -f "$SOURCE_FILEPATH" && "$SOURCE_FILE_SIZE" -gt 0 ]]; then
    echo "$PPA repo already present"
  else
    sudo apt-add-repository --yes "$PPA"
  fi
}

append_if_missing () {
  local CONTENT_LINE=$1
  local TARGET_FILE=$2

  if [ ! "$(grep -e "^$CONTENT_LINE$" $TARGET_FILE)" ]; then
    # This doesn't work because interpolates recursively
    # sudo bash -c "echo $CONTENT_LINE >> $TARGET_FILE"
    # Using sed instead, see <http://www.thegeekstuff.com/2009/11/unix-sed-tutorial-append-insert-replace-and-count-file-lines/#append_lines>
    sudo sed -i "$ a\
$CONTENT_LINE" "$TARGET_FILE"
    echo "----- added \"$CONTENT_LINE\" to $TARGET_FILE"
  else
    echo "----- line \"$CONTENT_LINE\" already in $TARGET_FILE"
  fi
}

make_symlink () {
  local TARGET=$1
  local LOCATION=$2
  local LOCATION_OWNER=
  local BASEDIR=

  if [[ -e $LOCATION ]]; then
    LOCATION_OWNER=$(ls -l $LOCATION | awk '{ print $3 }')
  else
    BASEDIR=$(dirname $LOCATION)
    if [[ ! -d "$BASEDIR" ]]; then mkdir -p "$BASEDIR"; fi
    LOCATION_OWNER=$(ls -l $BASEDIR | awk '{ print $3 }')
  fi

  # Options used:
  # -s (symbolic)
  # -f force (no error if the link exists or is a file)
  # -n (no dereference) treat destination that is a symlink to a directory as if
  #    it were a normal file
  # -T (no target directory), treat link name as a normal file (otherwise
  #    the link is created inside the existing directory)

  # If the location is already a symlink or does not exist, just create the link
  # afresh.
  if [[ -L $LOCATION || ! -e $LOCATION  ]]; then
    if [[ $LOCATION_OWNER == $USER ]]; then
      ln -sfnT $TARGET $LOCATION
    else
      sudo ln -sfnT $TARGET $LOCATION
    fi
  else
    if [[ $LOCATION_OWNER == $USER ]]; then
      mv $LOCATION{,.original}
      ln -sfnT $TARGET $LOCATION
    else
      sudo mv $LOCATION{,.original}
      sudo ln -sfnT $TARGET $LOCATION
    fi
  fi

  echo "symlink $LOCATION -> $TARGET"
}

abort_if_not_root () {
  if [[ ! $USER == 'root' ]]; then
    echo "This script must be run as root."
    exit 1
  fi
}

setup_rbenv () {
  local RBENV_PATH=$1
  local RBENV_PLUGINS_PATH=$RBENV_PATH/plugins
  local USERNAME=$2
  local GROUPNAME=$3
  local HOME_PATH=$4

  if [[ -d "$RBENV_PATH" ]]; then
    echo "rbenv is already installed"
  else
    mkdir -p "$RBENV_PATH"

    echo "Installing rbenv to $RBENV_PATH"
    git clone git://github.com/sstephenson/rbenv.git "$RBENV_PATH"

    echo "Installing ruby-build to $RBENV_PLUGINS_PATH/"
    mkdir -p "$RBENV_PLUGINS_PATH"
    git clone git://github.com/sstephenson/ruby-build.git "$RBENV_PLUGINS_PATH"/ruby-build

    append_if_missing 'export PATH="$HOME/.rbenv/bin:$PATH"' "$HOME_PATH/.bashrc"
    append_if_missing 'eval "$(rbenv init -)"' "$HOME_PATH/.bashrc"
  fi

  chown -R "$USERNAME:$GROUPNAME" "$RBENV_PATH"
}

install_ruby_with_rbenv_build () {
  local RBENV_PATH=$1
  local RUBY_VERSION=$2

  enable_rbenv_for_this_script "$RBENV_PATH"

  if [[ -d  "$RBENV_PATH/versions/$RUBY_VERSION" ]]; then
    echo "ruby $RUBY_VERSION already installed"
  else
    rbenv install "$RUBY_VERSION"
    rbenv shell "$RUBY_VERSION"

    # Basic utiilities
    gem install --no-rdoc --no-ri \
      bundler \
      rspec \
      pry \
      pry-doc \
      pry-nav \
      interactive_editor \
      rcodetools \
      mechanize \
      nokogiri \
      minitest \
      thin \
      sinatra \
      shotgun

      # Rails requires an older version of RDoc, and the installation is
      # interactive (prompts to rewrite the executable). For this reason
      # Rails can't be installed until a way is found to pass the option
      # not interactively.
      # rails \

    rbenv rehash
  fi
}

install_gem () {
  local GEM_NAME=$1
  local RBENV_PATH=$2
  local RUBY_VERSION=$3

  enable_rbenv_for_this_script "$RBENV_PATH"

  if [[ -z "$(find $RBENV_PATH/versions/$RUBY_VERSION/lib/ruby/gems/*/gems/ -iname $GEM_NAME-*)" ]]; then
    gem install --no-rdoc --no-ri "$GEM_NAME"
  else
    echo "gem '$GEM_NAME' is already installed"
  fi

  rbenv rehash
}

enable_rbenv_for_this_script () {
  local RBENV_PATH=$1

  export RBENV_ROOT="$RBENV_PATH"
  export PATH="$RBENV_PATH/bin:$RBENV_PATH/libexec:$PATH"
  eval "$(rbenv init -)"
}

apt_update_if_less_then_minutes_ago () {
  local MINUTES_AGO=$1

  # Get the times in the format 201211041326
  local LAST_APT_UPDATE=$(( `ls -lt --time-style="+%Y%m%d%H%M" /var/lib/apt/lists/ | grep -o "\([0-9]\{12\}\)" -m 1` ))
  local CURRENT_TIME=$(( `date '+%Y%m%d%H%M'` ))
  local TIME_SINCE_LAST_APT_UPDATE=$(( $CURRENT_TIME - $LAST_APT_UPDATE ))

  if [[ $TIME_SINCE_LAST_APT_UPDATE -gt $MINUTES_AGO ]]; then
    echo "Updating the apt-get index..."
    sudo apt-get update -qq
    echo "done"
  else
    echo "apt package index updated less than $MINUTES_AGO minutes ago"
  fi
}

apt_update_if_not_recent () {
  apt_update_if_less_then_minutes_ago "60"
}

# NOTE: this is only required by Vagrant
apt_force_upgrade () {
  # See: https://github.com/mitchellh/vagrant/issues/289,
  # seems specifically related to a version of the precise64 box.
  # Prevent grub modal dialogue due to changed disk UUID.
  export DEBIAN_FRONTEND=noninteractive

  echo "Upgrading default packages."
  apt-get -y \
    -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" \
    upgrade
}

reuse_apt_cache () {
  if [[ -f /vagrant/precise-packages.tar ]]; then
    echo "Reusing previously downloaded packages."
    cd /var/cache/apt/archives
    tar xvf /vagrant/precise-packages.tar
    cd -
  fi
}

create_or_update_apt_cache () {
  if [[ -f /vagrant/precise-packages.tar ]]; then
    echo "Updating the archive of downloaded packages."
    cd /var/cache/apt/archives
    tar uavf /vagrant/precise-packages.tar . --exclude=lock --exclude=partial
    cd -
  else
    echo "Creating a local archive of downloaded packages for the next runs."
    cd /var/cache/apt/archives
    tar cvf /vagrant/precise-packages.tar . --exclude=lock --exclude=partial
    cd -
  fi
}

# Note: the password will be hard-coded to "conan"
setup_super_user () {
  local USERNAME=$1

  # Create the super user with password 'conan'
  if [[ $(id $USERNAME 2>/dev/null) ]]; then
    echo "User '$USERNAME' exists."
  else
    # Create $USERNAME user with home directory, default login shell and password conan
    sudo useradd $USERNAME -m -p '$6$OPUPv.qo$WpEow9GzqV6EsVjaGl0DHs/xMeInVS3MOfF8M/d0bD.UzBzbY7KyN.QIemM2KNwTLrNzb7Rds2oTXuvAgxyiV0' -s /bin/bash
    echo "User '$USERNAME' with password 'conan' added"
    sudo usermod -a -G sudo $USERNAME
    echo "User '$USERNAME' added to the 'sudo' group"
  fi

  # Allow the super user to sudo without password.
  if [ -f /etc/sudoers.d/"$USERNAME"_sudoers ]; then
    echo "User '$USERNAME' is already sudoer without password."
  else
    sudo bash -c "echo '$USERNAME ALL=(ALL) NOPASSWD: ALL' > $USERNAME-sudoers"
    # the next commands requires sudo even if run as root, otherwise
    # the owner of the file will remain "vagrant" or whatever user is used
    # to execute this.
    sudo chown root:root "$USERNAME-sudoers"
    sudo chmod 0440 "$USERNAME-sudoers"
    sudo mv "$USERNAME-sudoers" /etc/sudoers.d/
    echo "User '$USERNAME' added to sudoers without password."
  fi
}

waiting_for_server_up () {
  local SECS=$1
  local SERVER_ROOT=$2
  local SERVER_COMMAND=$3
  local OK_MESSAGE=$4
  local FAIL_MESSAGE=$5
  local SERVER_IS_UP=false
  local HAS_BEEN_EXECUTED=false

  echo
  echo "Waiting max $SECS seconds for $SERVER_ROOT..."

  echo "$SECS"
  echo "$SERVER_COMMAND"

  local i=1

  for ((i;i<=$SECS;i=i+1)); do
    if $SERVER_IS_UP && ! $HAS_BEEN_EXECUTED; then
      $SERVER_COMMAND 2>/dev/null
      if [[ $? == 0 ]]; then HAS_BEEN_EXECUTED=true; fi
    elif ! $SERVER_IS_UP; then
      sleep 1
      curl $SERVER_ROOT > /dev/null
      if [[ $? == 0 ]]; then SERVER_IS_UP=true; fi
    fi
  done

  if $SERVER_IS_UP && $HAS_BEEN_EXECUTED; then
    echo "$ok_message"
  else
    echo "$fail_message"
  fi
}

waiting_for_jenkins () {
  local SERVER_COMMAND=$1

  waiting_for_server_up \
    120 \
    "http://localhost:8080/" \
    "$SERVER_COMMAND" \
    "Executed $SERVER_COMMAND" \
    "Failed to execute $SERVER_COMMAND"
}

install_jenkins_plugin () {
  local plugin_name=$1
  local jenkins_home=$2
  wget "http://updates.jenkins-ci.org/latest/$plugin_name.hpi" -O "$jenkins_home/plugins/$plugin_name.jpi"
}

remove_password_from_pdf () {
  local INPUT_FILE=$1

  gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite \
    -sOutputFile="$INPUT_FILE-unencrypted.pdf" \
    -c .setpdfwrite \
    -f "$INPUT_FILE"
}
