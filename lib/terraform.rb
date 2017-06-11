require 'yaml'

module Terraform
  DEFAULT_AWS_REGION='eu-west-2'
  DEFAULT_COMPONENTS_BUCKET_NAME='tobyclemson-mining-operations'
  DEFAULT_DOMAIN_NAME='eth-quest.net'

  def self.backend_config_for(key)
    {
        bucket: DEFAULT_COMPONENTS_BUCKET_NAME,
        key: key,
        region: DEFAULT_AWS_REGION
    }
  end

  def self.common_state_key
    "mining-node/deployment-state/common/default.tfstate"
  end

  def self.network_state_key_for(deployment_identifier)
    "mining-node/deployment-state/network/#{deployment_identifier}.tfstate"
  end

  def self.common_vars
    {
        region: DEFAULT_AWS_REGION,

        domain_name: DEFAULT_DOMAIN_NAME
    }
  end

  def self.network_vars_for(opts)
    bastion_configuration = YAML.load_file('config/infra/bastion.yml')
    bastion_ssh_allowed_cidrs = bastion_configuration['ssh_allowed_cidrs']

    bastion_ssh_public_key_path =
        File.join(Dir.pwd, 'config/secrets/keys/bastion/ssh.public')

    {
        region: DEFAULT_AWS_REGION,
        vpc_cidr: '10.0.0.0/16',

        component: 'mining-node',
        deployment_identifier: opts[:deployment_identifier],

        bastion_ssh_public_key_path: bastion_ssh_public_key_path,
        bastion_ssh_allow_cidrs: bastion_ssh_allowed_cidrs.join(','),

        state_bucket: DEFAULT_COMPONENTS_BUCKET_NAME,
        state_common_key: common_state_key
    }
  end
end
