#
# Author:: John Bellone (<jbellone@bloomberg.net>)
# Cookbook Name:: netrc
# Cookbook:: default
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
include_recipe 'netrc::default'

# This assumes a certain format for the encrypted data bags that are
# stored in Chef Vault. Please read documentation to see examples.
node['netrc']['users'].each do |username|
  item = chef_vault_item(node['netrc']['bag_name'], username)[node.chef_environment]

  netrc username do
    machines item['machines']
  end
end unless node['netrc']['users'].empty?
