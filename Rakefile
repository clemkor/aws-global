require 'securerandom'
require 'git'
require 'semantic'
require 'rake_terraform'

RakeTerraform.define_installation_tasks(version: '0.9.8')

namespace :release do
  desc 'Increment and push tag'
  task :tag do
    repo = Git.open('.')
    tags = repo.tags
    latest_tag = tags.map { |tag| Semantic::Version.new(tag.name) }.max
    next_tag = latest_tag.increment!(:patch)
    repo.add_tag(next_tag.to_s)
    repo.push('origin', 'master', tags: true)
  end
end
