module CampaignMonitorSubscriber
  require 'campaigning'
  CM_CONFIG = YAML::load_file(File.join("config/campaign_monitor_subscriber_config.yml"))
  ::CAMPAIGN_MONITOR_API_KEY = CM_CONFIG['api_key']  

  def subscribe_me_using(email_field, custom_fields={})
    return if CM_CONFIG[::Rails.env] == false
    after_create do |record|
      begin
        custom_fields = custom_fields.inject({}) { |h, (k, v)| h[k] = record.send(v); h }
        s = Campaigning::Subscriber.new(record.send(email_field), custom_fields["name"])
        s.add!(CM_CONFIG['list_id'], custom_fields)
      rescue RuntimeError
      end
    end

    after_destroy do |record|
      begin
        Campaigning::Subscriber.unsubscribe!(record.send(email_field), CM_CONFIG['list_id'])
      rescue RuntimeError
      end
    end
  end
end

ActiveRecord::Base.extend(CampaignMonitorSubscriber)