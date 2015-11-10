require 'spec_helper'

describe 'netrc::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge('netrc::default') }

  context 'with default node attributes' do
    it { expect(chef_run).to install_chef_gem('netrc').with(version: '= 0.11.0') }
  end
end
