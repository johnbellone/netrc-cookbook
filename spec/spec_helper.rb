require 'chefspec'
require 'chefspec/berkshelf'
require 'coveralls'

Coveralls.wear!

RSpec.configure do |config|
  config.color = true
  config.alias_example_group_to :describe_attribute, type: :attribute
  config.alias_example_group_to :describe_recipe, type: :recipe
  config.alias_example_group_to :describe_resource, type: :library
  config.alias_example_group_to :describe_provider, type: :library

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  Kernel.srand config.seed
  config.order = :random

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end

at_exit { ChefSpec::Coverage.report! }

RSpec.shared_context 'attribute tests', type: :attribute do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04').converge('netrc::default') }
end

RSpec.shared_context 'library tests', type: :library do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04', step_into: 'netrc').converge(example_recipe) }
  let(:node) { chef_run.node }
end

RSpec.shared_context 'recipe tests', type: :recipe do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node, server|
      node.set['dev_mode'] = true
      node.set['netrc']['users'] = %w(jbellone)
      server.create_data_bag('netrc', {
        'jbellone' => {
          '_default' => {
            'machines' => [
              {
                'host' => 'test-r1n1.local',
                'login' => 'jbellone',
                'password' => 'secretsauce'
              }
            ]
          }
        }
      })
    end.converge(described_recipe)
  end
end
