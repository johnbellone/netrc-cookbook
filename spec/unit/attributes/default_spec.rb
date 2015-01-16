require 'spec_helper'

describe_attribute 'netrc::default' do
  it { expect(chef_run.node['netrc']['bag_name']).to eq('netrc') }
  it { expect(chef_run.node['netrc']['users']).to eq([]) }
end
