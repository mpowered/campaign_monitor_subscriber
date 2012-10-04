# This module defines the CMS subscription callbacks.
# The callbacks are included in a model that calls #subscribe_me_using.
module CampaignMonitorSubscriber
  module SubscriptionHooks

    extend ActiveSupport::Concern

    included do
      after_create do |record|
        logger.debug "\n* Adding '#{record.cms_email}' to CM"

        begin
          CreateSend::Subscriber.add(
            cms_config.list_id,
            record.cms_email,
            record.cms_name,
            [record.cms_custom_fields],
            true
          )
        rescue CreateSend::CreateSendError => err
          @@log.info err.message
        end
      end


      after_destroy do |record|
        logger.debug "\n* Removing '#{record.cms_email}' from CM"

        begin
          s = CreateSend::Subscriber.new(
            cms_config.list_id,
            record.cms_email
          )
          s.unsubscribe
        rescue CreateSend::CreateSendError => err
          @@log.info err.message
        end
      end

    end
  end
end
