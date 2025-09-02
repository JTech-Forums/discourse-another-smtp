# frozen_string_literal: true

# name: discourse-another-smtp
# about: Another smtp server for emails that banned my main-smtp
# version: 0.0.1
# authors: Lhc_fl
# url: https://github.com/Lhcfl/discourse-another-smtp
# required_version: 3.0.0

enabled_site_setting :discourse_another_email_enabled

after_initialize do
  
  DiscourseEvent.on(:before_email_send) do |*params|

    if SiteSetting.discourse_another_email_enabled
  
      message, type = *params

      message.delivery_method.settings[:authentication] = SiteSetting.discourse_another_email_smtp_authentication_mode
      message.delivery_method.settings[:address] = SiteSetting.discourse_another_email_smtp_address
      message.delivery_method.settings[:port] = SiteSetting.discourse_another_email_smtp_port
      message.delivery_method.settings[:password] = SiteSetting.discourse_another_email_smtp_password
      message.delivery_method.settings[:user_name] = SiteSetting.discourse_another_email_smtp_username
    end
  
  end
      
  
end

# message.delivery_method.settings is like:
# {:address=>"localhost",
#  :port=>1025,
#  :domain=>"localhost.localdomain",
#  :user_name=>nil,
#  :password=>nil,
#  :authentication=>nil,
#  :enable_starttls=>nil,
#  :enable_starttls_auto=>true,
#  :openssl_verify_mode=>nil,
#  :ssl=>nil,
#  :tls=>nil,
#  :open_timeout=>5,
#  :read_timeout=>5,
#  :return_response=>true}
