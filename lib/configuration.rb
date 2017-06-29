require 'yaml'
require 'hiera'
require 'active_support'
require 'active_support/core_ext/hash/keys'

class Configuration
  def initialize(args = {}, scope = {}, hiera = nil)
    @args = args
    @scope = scope
    @hiera = hiera || Hiera.new(config: 'config/hiera.yaml')
  end

  def for_args(args)
    Configuration.new(args, @scope, @hiera)
  end

  def for_scope(scope)
    Configuration.new(@args, scope, @hiera)
  end

  def method_missing(method, *args, &block)
    full_scope = {"cwd" => Dir.pwd}
                     .merge(@scope.stringify_keys)
                     .merge({args: @args})
    @hiera.lookup(method.to_s, nil, full_scope)
  end
end
