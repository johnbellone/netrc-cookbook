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

    actions(:create, :remove)

    attribute(:user, kind_of: String, name_attribute: true)
    attribute(:path, kind_of: String, default: lazy { File.join(Dir.home(user), Netrc.netrc_filename) })

    # Add/modify a whole bunch of machines in a single shot.
    attribute(:machines, kind_of: Array, default: [])

    # For use when simply adding a single machine.
    attribute(:host, kind_of: String)
    attribute(:login, kind_of: String)
    attribute(:password, kind_of: String)
  end

  class Provider::Netrc < Provider
    include Poise

    def action_create
      converge_by("Write netrc for '#{new_resource.user}'") do
        netrc = Netrc.read(new_resource.path)

        new_resource.machines.each do |m|
          netrc.new_item(m['host'], m['login'], m['password'])
        end

        if new_resource.host
          newrc[ new_resource.host ] = new_resource.login, new_resource.password
        end

        netrc.save
      end
    end

    def action_remove
      converge_by("Remove netrc for '#{new_resource.user}'") do
        file new_resource.path do
          action :delete
        end
      end
    end
  end
end
