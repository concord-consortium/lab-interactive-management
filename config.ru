# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

use Shutterbug::Rackapp do |config|
  config.resource_dir       = "/Users/tdyer/tmp"
  config.uri_prefix       = "http://shutterbug.herokuapp.com"
  config.path_prefix      = "/shutterbug"
  # config.phantom_bin_path = "/app/vendor/phantomjs/bin/phantomjs"
  config.phantom_bin_path = "/usr/local/bin/phantomjs"
end

run Rails.application
