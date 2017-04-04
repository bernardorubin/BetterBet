source 'https://rubygems.org'
ruby '2.3.3'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
# https://github.com/tyrauber/stock_quote
# https://rubygems.org/gems/money-open-exchange-rates

# MY GEMS 💎 //////////////////////////////////////////////
gem "feedjira"
gem 'bootstrap-social-rails'
gem 'omniauth-facebook'
gem 'inherited_resources', '~> 1.7'
gem 'activeadmin', '1.0.0.pre5'
gem 'cancancan'
gem 'virtus'
gem 'aasm'
gem 'timezone'
gem 'time_difference'
gem 'groupdate'
# gem "binding_of_caller"
gem 'validates_timeliness'
gem 'chosen-rails'
gem 'simple_form'
gem 'devise'
gem "font-awesome-rails"
gem 'bootstrap-sass', '~> 3.3.6'
gem 'descriptive_statistics', '~> 2.4.0', :require => 'descriptive_statistics/safe'
gem 'better_errors'
gem 'stock_quote'
gem 'chartkick'
gem 'yahoo-finance', '~> 1.2'
gem 'pry'
#///////////////////////////////////////////////////////

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 3.1.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  gem 'awesome_print'
  gem 'interactive_editor'
  gem 'hirb'
  gem 'rails-erd'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
