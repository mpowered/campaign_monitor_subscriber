# These methods become part of all models that call #subscribe_me_using regardless
# of the environment and other qualifying criteria.
# We keep this light so that if the current environment fails to qualify for subscription
# we haven't created a lot of bootstrapping overhead.
module CampaignMonitorSubscriber
  module BasicConfiguration
    require 'yaml'

    private
      # All yaml config is namespaced under the environment name (the same way
      # database.yml does it)
      def raw_cms_config
        @raw_cms_config ||= YAML.load(ERB.new(File.read("config/campaign_monitor_subscriber.yml")).result)[Rails.env]
      end
  end
end
