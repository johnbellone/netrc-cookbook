require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'
require 'netrc'
require 'chef-vault'

RSpec.configure do |c|
  c.platform = 'ubuntu'
  c.version = '14.04'
end
