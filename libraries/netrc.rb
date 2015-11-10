#
# Cookbook: netrc
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
require 'poise'
require 'fileutils'

module NetrcCookbook
  module Resource
    class NetrcFile < Chef::Resource
      include Poise(fused: true)
      provides(:netrc_file)

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:owner, kind_of: String, default: 'root')
      attribute(:group, kind_of: String, default: 'root')

      attribute(:machines, kind_of: Array, default: [])

      action(:create) do
        netrc = ::Netrc.read(new_resource.path)

        new_resource.machines.each do |m|
          netrc[m['host']] = m['login'], m['password']
        end

        new_resource.updated_by_last_action = true if netrc.save
        FileUtils.chown(new_resource.owner,
                        new_resource.group,
                        new_resource.path)
        FileUtils.chmod(384, new_resource.path)
      end

      action(:delete) do
        notifying_block do
          file new_resource.path do
            action :delete
          end
        end
      end
    end
  end
end
