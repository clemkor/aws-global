require 'ruby_terraform'
require 'active_support'
require 'active_support/core_ext/hash/keys'

class Terraform
  attr_reader :region,
              :components_bucket_name

  def initialize(opts)
    opts = opts.to_options
    missing_keys = [
        :region,
        :components_bucket_name
    ].reject {|key| opts.has_key?(key)}

    unless missing_keys.empty?
      raise ArgumentError.new("Error: must specify: #{missing_keys}")
    end

    @region = opts[:region]
    @components_bucket_name = opts[:components_bucket_name]
  end

  def backend_config_for(key)
    {
        bucket: components_bucket_name,
        key: key,
        region: region
    }
  end
end
