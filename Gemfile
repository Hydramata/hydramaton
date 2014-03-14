source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass', '~>2.3'
gem 'devise'
gem 'devise_cas_authenticatable'
gem 'figaro'
gem 'mysql2'
gem 'simple_form'
gem 'hydramata-core', path: './hydramata-core'
gem 'hydramata-deposit', path: './hydramata-deposit'
gem 'hydramata-layout', path: './hydramata-layout'

group :development do
  if ! ENV['TRAVIS']
    gem 'rspec-yenta'
    gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
    gem 'guard-bundler'
    gem 'guard-rails'
    gem 'guard-rspec'
    gem 'rb-fchange', :require=>false
    gem 'rb-fsevent', :require=>false
    gem 'rb-inotify', :require=>false
    gem 'byebug'
    gem 'better_errors'
    gem 'quiet_assets'
    gem 'yard'
  end
  gem 'rails_layout'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'rspec-given'
end
group :production do
  gem 'unicorn'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
end
