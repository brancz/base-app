source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
gem 'slim-rails'
gem 'pg'
gem 'settingslogic'
gem 'active_model_serializers'
gem 'rails_12factor', group: :production
gem 'kaminari'

gem 'unicorn'
gem 'rack-handlers'

gem 'devise'
gem 'warden'
gem 'cancan'
gem 'omniauth'
gem 'omniauth-github'
gem 'redis'
gem 'redis-namespace'
gem 'micro_token'
gem 'better_errors'

# Misc
gem 'foreman'

# CSS
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'

# JS
gem 'therubyracer', platforms: :ruby
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'rails-assets-d3'
gem 'rails-assets-angular'
gem 'rails-assets-angular-route'
gem 'rails-assets-angular-animate'
gem 'rails-assets-angular-resource'
gem 'rails-assets-angular-cookies'
gem 'rails-assets-angular-ui-router'
gem 'rails-assets-angular-loading-bar'
# not js but necessary for rails + angularjs
gem 'angular_rails_csrf'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
  gem 'railroady', require: false
end

group :test, :development do
  gem 'mailcatcher'
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'jasmine-rails'
  gem 'coveralls', require: false
  gem 'rails_best_practices'
end
