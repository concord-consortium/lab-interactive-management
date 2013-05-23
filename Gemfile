source 'https://rubygems.org'
ruby '1.9.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'

# Use postgres as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'

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
gem 'jbuilder', '~> 1.0.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# copied from server/Gemfile in next lab project
gem 'rack-rewrite'

gem 'thin'

def darwin_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /darwin/ && require_as
end

def linux_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /linux/ && require_as
end

def windows_only(require_as)
  RbConfig::CONFIG['host_os'] =~ /mingw|mswin/i && require_as
end

group :development do
  gem "guard",       "~> 1.6.2"
  gem "guard-rspec", "~> 2.4.1"
  # FS Notification libraries for guard (non-polling)
  gem 'rb-fsevent', "~> 0.9.3", :require => darwin_only('rb-fsevent')
  gem 'rb-inotify', "~> 0.8.8", :require => linux_only('rb-inotify')
  gem 'wdm',        "~> 0.1.0", :require => windows_only('wdm')
  # Growl Notification Transport Protocol (used by guard)
  gem 'ruby_gntp',  "~> 0.3.4"
end

group :development, :test do
  # debuggers ...
  gem "pry"
  gem "pry-nav"
  gem "pry-stack_explorer"
  gem "awesome_print"
  gem "rspec-rails"
end

group :test do
  gem "webmock"
  gem "factory_girl_rails",  "~> 4.2.1"
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
