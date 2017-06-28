$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'securerandom'
require 'git'
require 'semantic'
require 'rake_terraform'

require 'configuration'

RakeTerraform.define_installation_tasks(
    path: File.join(Dir.pwd, 'vendor', 'terraform'),
    version: '0.9.8')

configuration = Configuration.new

task :default => [
    :'common:plan',
    :'network:plan'
]

namespace :common do
  RakeTerraform.define_command_tasks do |t|
    t.configuration_name = 'common'
    t.source_directory = 'infra/common'
    t.work_directory = 'build'

    t.backend_config = lambda do
      configuration.terraform.backend_config_for(
          configuration.common_state_key)
    end

    t.vars = configuration
                 .for_scope(role: 'common')
                 .vars
  end
end

namespace :network do
  RakeTerraform.define_command_tasks do |t|
    t.argument_names = [:deployment_identifier]

    t.configuration_name = 'mining network'
    t.source_directory = 'infra/network'
    t.work_directory = 'build'

    t.backend_config = lambda do |args|
      configuration.terraform.backend_config_for(
          configuration
              .for_args(args)
              .network_state_key)
    end

    t.vars = lambda do |args|
      configuration
          .for_args(args)
          .for_scope(role: 'network')
          .vars
    end
  end
end

namespace :release do
  desc 'Increment and push tag'
  task :tag do
    repo = Git.open('.')
    tags = repo.tags
    latest_tag = tags.map {|tag| Semantic::Version.new(tag.name)}.max
    next_tag = latest_tag.increment!(:patch)
    repo.add_tag(next_tag.to_s)
    repo.push('origin', 'master', tags: true)
  end
end
