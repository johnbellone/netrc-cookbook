#
# Author:: John Bellone (<jbellone@bloomberg.net>)
# Cookbook Name:: netrc
# Library:: default
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#

class Chef
  class Resource::Netrc < Resource
    include Poise

    actions(:create, :create_if_missing)

    attribute(:host, kind_of: String, name_attribute: true)
    attribute(:user, kind_of: String)
    attribute(:path, kind_of: String, default: lazy { Dir.home(user) })
    attribute(:login, kind_of: String)
    attribute(:password, kind_of: String)
  end

  class Provider::Netrc < Provider
    include Poise
    require_chef_gem 'netrc'

    def action_create
      converge_by "Creating netrc for '#{new_resource.user}'" do
        netrc = Netrc.new(new_resource.path)
        netrc[new_resource.host] = new_resource.login, new_resource.password
        netrc.save
      end
    end

    def create_if_missing
    end
  end
end
