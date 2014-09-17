require 'ostruct'

module BaseApp
  def self.config
    config = OpenStruct.new
    config.host = ENV['HOST']
    config.email = ENV['EMAIL']
    config.smtp = BaseApp.smtp_config
    config.oauth = BaseApp.oauth_config
    config
  end

  def self.smtp_config
    smtp_config = OpenStruct.new
    smtp_config.enabled = !ENV['SMTP_HOST'].blank?
    if smtp_config.enabled
      smtp_config.host = ENV['SMTP_HOST']
      smtp_config.port = ENV['SMTP_PORT']
      smtp_config.user = ENV['SMTP_USER']
      smtp_config.pass = ENV['SMTP_PASS']
      smtp_config.domain = ENV['SMTP_DOMAIN']
    end
    smtp_config
  end

  def self.oauth_config
    oauth_config = OpenStruct.new
    oauth_config.enabled = !ENV['GITHUB_CLIEND_ID'].blank?
    if oauth_config.enabled
      oauth_config.client_id = ENV['GITHUB_CLIENT_ID']
      oauth_config.client_secret = ENV['GITHUB_CLIENT_SECRET']
    end
    oauth_config
  end
end
