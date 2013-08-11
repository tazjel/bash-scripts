# Install RVM itself

\curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

# REE 2010-02 on ubuntu 12.04

sudo apt-get install -y --no-install-recommends gcc-4.4 g++-4.4

sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.4 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 50
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.4 100
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 50
sudo update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-4.4 100
sudo update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-4.6 50

rvm pkg install openssl
rvm install ree-1.8.7-2010.02 --with-openssl-dir=$rvm_path/usr
#
# Applying patch /usr/local/rvm/patches/ree/1.8.7/2010.02/tcmalloc.patch                                                                                                          │·········
# Applying patch /usr/local/rvm/patches/ree/1.8.7/stdout-rouge-fix.patch                                                                                                          │·········
# Applying patch /usr/local/rvm/patches/ree/1.8.7/no_sslv2.diff                                                                                                                   │·········
# Applying patch /usr/local/rvm/patches/ree/lib64.patch
#


# OTHER RUBIES

rvm install ruby-1.9.2-p320
rvm install ruby-1.9.3-p194
rvm install ruby-1.9.3-p327

# Set Ruby version

rvm default ruby-1.9.3-p327
