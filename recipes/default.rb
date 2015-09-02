#
# Cookbook: netrc
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
  chef_gem 'netrc' do # ~FC009
    version '= 0.10.3'
    compile_time true
  end
else
  chef_gem 'netrc' do
    version '= 0.10.3'
    action :nothing
  end.run_action(:install)
end

require 'netrc'
