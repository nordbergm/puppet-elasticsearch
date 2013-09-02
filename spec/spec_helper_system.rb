require 'rspec-system/spec_helper'
require 'rspec-system-puppet/helpers'

include RSpecSystemPuppet::Helpers

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Enable colour
  c.tty = true

  c.include RSpecSystemPuppet::Helpers

  # This is where we 'setup' the nodes before running our tests
  c.before :suite do
    # Install puppet
    puppet_install
    puppet_master_install
    system_run('wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.3.noarch.rpm /tmp')
    system_run('rpm -Uhv /tmp/elasticsearch-0.90.3.noarch.rpm')

    system_run('puppet module install puppetlabs/stdlib')
    # Replace mymodule with your module name
    puppet_module_install(:source => proj_root, :module_name => 'elasticsearch')
  end
end
