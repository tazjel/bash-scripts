#!/usr/bin/env bash

[ ! -d /cookbooks ] && mkdir /cookbooks
[ ! -d /etc/chef ] && mkdir /etc/chef
[ ! -f /etc/chef/solo.rb ] && touch /etc/chef/solo.rb
[ ! -f /etc/chef/node.json ] && touch /etc/chef/node.json



chmod go+w -R /cookbooks /etc/chef

echo 'cookbook_path "/cookbooks"' >> /etc/chef/solo.rb

echo '{
 "run_list": ["recipe[workstation]"]
}' >> /etc/chef/node.json

