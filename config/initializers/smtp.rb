if Rails.env.production?

  BaseApp::Application.config.action_mailer.default_url_options = { :host => BaseApp.config.smtp.domain }
  BaseApp::Application.config.mailer_sender = BaseApp.config.email
  ActionMailer::Base.default_options = {
    :from => BaseApp.config.email
  }

  if BaseApp.config.smtp.enabled
    ActionMailer::Base.smtp_settings = {
      :port => BaseApp.config.smtp.port,
      :address => BaseApp.config.smtp.host,
      :user_name => BaseApp.config.smtp.user,
      :password => BaseApp.config.smtp.password,
      :domain => BaseApp.config.smtp.domain,
      :authentication => :plain
    }
    ActionMailer::Base.delivery_method = :smtp
  else
    ActionMailer::Base.delivery_method = :sendmail
  end

end
