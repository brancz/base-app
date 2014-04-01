class Settings < Settingslogic
  source "#{Rails.root}/config/config.yml"
  namespace Rails.env
end

Settings['redis'] ||= Settingslogic.new({})
Settings.redis['url'] ||= ENV["REDISTOGO_URL"]

Settings['omniauth'] ||= Settingslogic.new({})
Settings.omniauth['enabled'] ||= false
