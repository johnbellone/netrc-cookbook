require 'spec_helper'

describe 'netrc::data_bag' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge('netrc::data_bag') }

  context 'with default node attributes' do
    it { expect(chef_run).to include_recipe('chef-vault::default') }
    it { expect(chef_run).to include_recipe('netrc::default') }
  end
end
