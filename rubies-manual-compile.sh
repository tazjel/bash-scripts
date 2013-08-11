# ##############
# # RUBY 1.9.3 #
# ##############

# if [ ! -f $HOME/Downloads/ruby/ruby-1.9.3-p125.tar.gz ]; then
#  cd ~/Downloads/ruby
#  wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p125.tar.gz
#  cd ~
# else
#  echo "ruby 1.9.3-p125 already downloaded"
# fi

# if [ ! -d $HOME/.rbenv/versions/1.9.3-p125 ]; then
#  cd $HOME/Downloads/ruby
#  rm -rf ruby-1.9.3-p125/
#  tar xfz ruby-1.9.3-p125.tar.gz
#  cd ruby-1.9.3-p125/
#  ./configure --prefix=$HOME/.rbenv/versions/1.9.3-p125
#  make
#  make install
#  cd $HOME/Downloads/ruby
#  rm -rf ruby-1.9.3-p125/
#  cd ~
# else
#  echo "ruby 1.9.3-p125 already installed with rbenv"
# fi

# # append_to_bashrc () {
# #   if [ ! "$(grep "$1" ~/.bashrc)" ]; then
# #     echo "$1" >> ~/.bashrc
# #     echo "added $1 to .bashrc"
# #   else
# #     echo "----- line $1 already in .bashrc"
# #   fi
# # }



# #### ##############
# #### # RUBY 1.9.2 #
# #### ##############
# ####
# #### if [ ! -f $HOME/Downloads/ruby/ruby-1.9.2-p320.tar.gz ]; then
# ####   cd ~/Downloads/ruby
# ####   wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p320.tar.gz
# ####   cd ~
# #### else
# ####   echo "ruby 1.9.2-p320 already downloaded"
# #### fi
# ####
# #### if [ ! -d $HOME/.rbenv/versions/1.9.2-p320 ]; then
# ####   cd $HOME/Downloads/ruby
# ####   rm -rf ruby-1.9.2-p320/
# ####   tar xfz ruby-1.9.2-p320.tar.gz
# ####   cd ruby-1.9.2-p320/
# ####   ./configure --prefix=$HOME/.rbenv/versions/1.9.2-p320
# ####   make
# ####   make install
# ####   cd $HOME/Downloads/ruby
# ####   rm -rf ruby-1.9.2-p320/
# ####   cd ~
# #### else
# ####   echo "ruby 1.9.2-p320 already installed with rbenv"
# #### fi

# ##############
# # RUBY 1.8.7 #
# ##############

# # TODO: download and install rubygems manually

# # if [ ! -f $HOME/Downloads/ruby/ruby-1.8.7-p370.tar.gz ]; then
# #   cd $HOME/Downloads/ruby
# #   wget http://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p370.tar.gz
# #   cd ~
# # else
# #  echo "ruby 1.8.7-p370 already downloaded"
# # fi

# # # TODO: avoid using rbenv-install if possible

# # if [ ! -d $HOME/.rbenv/versions/1.8.7-p370 ]; then
# #   rbenv install 1.8.7-p370
# # else
# #   echo "ruby 1.8.7-p370 already installed with rbenv"
# # fi

# ###########################
# # RUBY ENTERPRISE 2012.02 #
# ###########################

# if [ ! -f $HOME/Downloads/ruby/ruby-enterprise-1.8.7-2012.02.tar.gz ]; then
#  cd $HOME/Downloads/ruby
#  wget http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-1.8.7-2012.02.tar.gz
#  cd ~
# else
#  echo "ruby-enterprise-1.8.7-2012.02.tar.gz already downloaded"
# fi

# if [ ! -d $HOME/.rbenv/versions/ree-1.8.7-2012.02 ]; then
#  cd $HOME/Downloads/ruby
#  rm -rf ruby-enterprise-1.8.7-2012.02
#  tar xfz ruby-enterprise-1.8.7-2012.02.tar.gz
#  cd ruby-enterprise-1.8.7-2012.02/source/
#  ./configure --prefix=$HOME/.rbenv/versions/ree-1.8.7-2012.02
#  make
#  make install
#  cd ../rubygems
#  $HOME/.rbenv/versions/ree-1.8.7-2012.02/bin/ruby setup.rb
#  # <http://stackoverflow.com/questions/6761670/is-there-any-way-to-change-gcc-compilation-options-for-a-gem>
#  $HOME/.rbenv/versions/ree-1.8.7-2012.02/bin/gem install RedCloth -- --with-cflags=\"-O2 -pipe -march=native -Wno-unused-but-set-variable\"
#  cd $HOME/Downloads/ruby
#  rm -rf ruby-enterprise-1.8.7-2012.02
#  cd ~
# else
#  echo "ruby ree-1.8.7-2012.02 already installed with rbenv"
# fi

# ###########################
# # RUBY ENTERPRISE 2010.02 #
# ###########################

# # http://rubyforge.org/frs/download.php/71096/ruby-enterprise-1.8.7-2010.02.tar.gz

# cd ~

# #rbenv global 1.9.3-p327

# #rbenv rehash

# ########
# # CHEF #
# ########

# #if [ ! -d ~/.rbenv/versions/1.9.3-p327/lib/ruby/gems/1.9.1/gems/chef-10.16.2 ]; then
# #  gem install chef -v=10.16.2 --no-rdoc --no-ri
# #else
# #  echo "chef 10.16.2 is already installed"
# #fi

# #rbenv rehash

# #\curl -L https://get.rvm.io | bash -s stable
# #cd ~
# #ln -sf $HOME/Dropbox/dotfiles/.bashrc
# #ln -sf $HOME/Dropbox/dotfiles/.bash_aliases

# #. ~/.bashrc

