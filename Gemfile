source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Simple, secure token based authentication for Rails
gem 'devise_token_auth', '~> 0.1.31'
# blocking & throttling abusive requests
gem 'rack-attack', '~> 5.0', '>= 5.0.1'
# For background processing, mainly ActionMailer.
gem 'sucker_punch', '~> 2.0', '>= 2.0.2'
# Generate your JSON in an object-oriented and convention-driven manner.
# gem 'active_model_serializers', '~> 0.10.4'

# I18n extensions
gem 'rails-i18n', '~> 5.0', '>= 5.0.3'
gem 'devise-i18n', '~> 0.12.1'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
end

group :development do
  # Speeds up development by keeping your application running in the background.
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use Capistrano for deployment
  gem 'capistrano-rails'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Decorate your model with their corresponding schema.
  gem 'annotate'
  # Detect N+1 queries.
  gem 'bullet'
  # Better error pages with interactive repl.
  gem 'better_errors'
  gem 'binding_of_caller'
  # Better irb.
  gem 'hirb'
  # Load .env file variable into to global EVN[]
  gem 'dotenv-rails', '~> 2.2'
  # Intercept ActionMailer messages for popup instead of sending.
  gem 'letter_opener', '~> 1.4', '>= 1.4.1'
end

group :test do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
  gem 'faker', '~> 1.7', '>= 1.7.3'
  gem 'simplecov', :require => false
  gem "codeclimate-test-reporter", "~> 1.0.0", :require => false
end

group :production do
  # For Heroku deployment
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
