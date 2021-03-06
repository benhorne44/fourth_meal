source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'minitest-rails-capybara'
  gem 'better_errors'
  gem "binding_of_caller"
  gem 'launchy'
  gem 'pry'
  gem 'guard'
  gem 'guard-minitest'
  gem 'sqlite3'
  gem 'pg'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'dalli'
end

gem 'bootstrap-sass'
gem 'sorcery'
gem 'paperclip'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'aws-sdk', '~> 1.25'
gem 'resque'
gem 'redis-rails'
gem 'kaminari'
