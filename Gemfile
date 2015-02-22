ruby '2.2.0'
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use Postgres for production db
gem 'pg'

gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails'
gem 'slim-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-tablesorter'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Use HTTParty for fetching remote resources
gem 'httparty'

# Require a directory
gem 'require_all'

group :production do
  gem 'rails_12factor'
end

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'rubocop'
  #  gem 'rack-mini-profiler'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'pry-byebug'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end