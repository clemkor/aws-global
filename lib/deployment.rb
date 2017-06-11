module Deployment
  DEFAULT_DEPLOYMENT_IDENTIFIER='default'

  def self.identifier_for(args)
    ENV['DEPLOYMENT_IDENTIFIER'] ||
        args.deployment_identifier ||
        DEFAULT_DEPLOYMENT_IDENTIFIER
  end
end