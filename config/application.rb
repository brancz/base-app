require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'ostruct'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module BaseApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.to_prepare do
      DeviseController.respond_to :html, :json
    end

    config.host = ENV['HOST']
    config.email = ENV['EMAIL']

    config.smtp = OpenStruct.new
    config.smtp.enabled = !ENV['SMTP_HOST'].blank?
    if config.smtp.enabled
      config.smtp.host = ENV['SMTP_HOST']
      config.smtp.port = ENV['SMTP_PORT']
      config.smtp.user = ENV['SMTP_USER']
      config.smtp.pass = ENV['SMTP_PASS']
      config.smtp.domain = ENV['SMTP_DOMAIN']
    end

    config.oauth = OpenStruct.new
    config.oauth.enabled = !ENV['GITHUB_CLIEND_ID'].blank?
    if config.oauth.enabled
      config.oauth.client_id = ENV['GITHUB_CLIENT_ID']
      config.oauth.client_secret = ENV['GITHUB_CLIENT_SECRET']
    end
  end
end
