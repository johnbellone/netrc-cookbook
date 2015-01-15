#
# Author:: John Bellone (<jbellone@bloomberg.net>)
# Cookbook Name:: netrc
# Cookbook:: default
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#

include_recipe 'chef-sugar::default'
include_recipe 'chef-vault::default'

node['netrc']['users'].each do |username|
  item = chef_vault_item(node['netrc']['bag_name'], username)[node.chef_environment]

  item['machines'].each do |machine|
    netrc machine['host'] do
      user username
      login machine['login']
      password machine['password']
    end
  end
end unless node['netrc']['users'].empty
