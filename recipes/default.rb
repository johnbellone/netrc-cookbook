#
# Author:: John Bellone (<jbellone@bloomberg.net>)
# Cookbook Name:: netrc
# Cookbook:: default
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
include_recipe 'chef-vault::default'

chef_gem('netrc') do
  version node['netrc']['gem_version']
  action :nothing
end.run_action(:install)

require 'netrc'
