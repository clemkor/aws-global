require 'securerandom'
require 'git'
require 'semantic'
require 'rake_terraform'

require_relative 'lib/deployment'
require_relative 'lib/terraform'

RakeTerraform.define_installation_tasks(
    path: File.join(Dir.pwd, 'vendor', 'terraform'),
    version: '0.9.8')

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
      Terraform.backend_config_for(
          Terraform.common_state_key)
    end

    t.vars = lambda do
      Terraform.common_vars
    end
  end
end

namespace :network do
  RakeTerraform.define_command_tasks do |t|
    t.argument_names = [:deployment_identifier]

    t.configuration_name = 'mining network'
    t.source_directory = 'infra/network'
    t.work_directory = 'build'

    t.backend_config = lambda do |args|
      Terraform.backend_config_for(
          Terraform.network_state_key_for(
              Deployment.identifier_for(args)))
    end

    t.vars = lambda do |args|
      Terraform.network_vars_for(
          deployment_identifier: Deployment.identifier_for(args))
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
