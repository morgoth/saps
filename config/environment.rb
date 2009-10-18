RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
require 'lib/google_analytics'

Rails::Initializer.run do |config|

  config.action_controller.page_cache_directory = Rails.root + "/public/cache"

  config.gem "haml"
  config.gem "xml-simple", :lib => 'xmlsimple'
  config.gem "will_paginate"
  config.gem 'picasa'
  config.gem 'authlogic'
  config.gem "RedCloth", :lib => 'redcloth'

  config.time_zone = 'Warsaw'

  config.action_controller.session = {
    :session_key => '_untitled-7fb4c6_session',
    :secret      => '0beff2aa563f591c284a7c34e24f90e273d799d67e01a755dddfd43cfb619b82177205fc5b4236438d63ad356d2363f09a56e2336fae5b6bb0a9cf26c79993c4'
  }

  config.i18n.load_path += Dir[File.join(Rails.root, "config", "locales", "**", "*.{rb,yml}")]
  config.i18n.default_locale = :pl
  config.middleware.use Rack::GoogleAnalytics, ENV['GOOGLE_ANALYTICS_ID'] || 'xxxx-x'
end
