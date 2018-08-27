source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.2'
gem 'riak-client'
gem 'hashie'
gem 'representable'
gem 'dry-monads',   '~> 1.0' 

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'pry-byebug'
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'rspec'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
