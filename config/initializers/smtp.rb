if Rails.env.production?

  BaseApp::Application.config.action_mailer.default_url_options = { :host => BaseApp::Application.config.smtp.domain }
  BaseApp::Application.config.mailer_sender = BaseApp::Application.config.email
  ActionMailer::Base.default_options = {
    :from => BaseApp::Application.config.email
  }

  if BaseApp::Application.config.smtp.enabled
    ActionMailer::Base::Application.smtp_settings = {
      :port => BaseApp::Application.config.smtp.port,
      :address => BaseApp::Application.config.smtp.host,
      :user_name => BaseApp::Application.config.smtp.user,
      :password => BaseApp::Application.config.smtp.password,
      :domain => BaseApp::Application.config.smtp.domain,
      :authentication => :plain
    }
    ActionMailer::Base.delivery_method = :smtp
  else
    ActionMailer::Base.delivery_method = :sendmail
  end

end
