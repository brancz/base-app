class Settings < Settingslogic
  if File.exist?("#{Rails.root}/config/config.yml")
    source "#{Rails.root}/config/config.yml"
  else
    source "#{Rails.root}/config/config.yml.example"

    Settings['host'] = "base-app-flowerpot.herokuapp.com"
    Settings['email'] = "noreply@#{Settings.host}"

    Settings['smtp'] = Settingslogic.new({})
    Settings.smtp['enabled'] = false
    Settings.smtp['domain'] = Settings.host
  end
  namespace Rails.env
end

Settings['redis'] ||= Settingslogic.new({})
Settings.redis['url'] ||= ENV["REDISTOGO_URL"]

Settings['omniauth'] ||= Settingslogic.new({})
Settings.omniauth['enabled'] ||= false
