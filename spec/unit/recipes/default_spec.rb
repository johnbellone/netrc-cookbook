require 'spec_helper'

describe_recipe 'netrc::default' do
  it { expect(chef_run).to include_recipe('chef-sugar::default') }
  it { expect(chef_run).to include_recipe('chef-vault::default') }
  it { expect(chef_run).to create_netrc('jbellone') }
end
