$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'rake_terraform'
require 'confidante'

RakeTerraform.define_installation_tasks(
    path: File.join(Dir.pwd, 'vendor', 'terraform'),
    version: '0.11.1')

configuration = Confidante.configuration

task :default => [
    :'bootstrap:plan',
    :'common:plan'
]

namespace :bootstrap do
  RakeTerraform.define_command_tasks do |t|
    t.configuration_name = 'bootstrap'
    t.source_directory = 'infra/bootstrap'
    t.work_directory = 'build'

    t.state_file = File.join(Dir.pwd, 'state/bootstrap.tfstate')

    t.vars = lambda do
      configuration
          .for_scope(role: 'bootstrap')
          .vars
    end
  end
end

namespace :common do
  RakeTerraform.define_command_tasks do |t|
    t.configuration_name = 'common'
    t.source_directory = 'infra/common'
    t.work_directory = 'build'

    t.backend_config = lambda do
      configuration
          .for_scope(role: 'common')
          .backend_config
    end

    t.vars = lambda do
      configuration
          .for_scope(role: 'common')
          .vars
    end
  end
end
