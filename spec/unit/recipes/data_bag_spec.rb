require 'spec_helper'

describe_recipe 'netrc::data_bag' do
  it { expect(chef_run).to include_recipe('netrc::default') }
  it { expect(chef_run).to create_netrc('jbellone') }
end
