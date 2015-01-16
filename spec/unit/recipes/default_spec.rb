require 'spec_helper'

describe_recipe 'netrc::default' do
  it { expect(chef_run).to include_recipe('chef-vault::default') }
  it { expect(chef_run).to install_chef_gem('netrc') }
end
