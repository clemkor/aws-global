require 'yaml'
require 'hiera'
require 'active_support'
require 'active_support/core_ext/hash/keys'

require_relative 'terraform'

class Configuration
  attr_reader :terraform

  def initialize(args = {}, scope = {}, hiera = nil, terraform = nil)
    @args = args
    @scope = scope
    @hiera = hiera || Hiera.new(config: 'config/hiera.yaml')
    @terraform = terraform || Terraform.new(
        region: region,
        components_bucket_name: components_bucket_name)
  end

  def for_args(args)
    Configuration.new(args, @scope, @hiera, @terraform)
  end

  def for_scope(scope)
    Configuration.new(@args, scope, @hiera, @terraform)
  end

  def method_missing(method, *args, &block)
    full_scope = {"cwd" => Dir.pwd}
                     .merge(@scope.stringify_keys)
                     .merge({args: @args})
    puts full_scope
    @hiera.lookup(method.to_s, nil, full_scope)
  end
end
