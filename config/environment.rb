RAILS_GEM_VERSION = '2.2.2'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.
	config.action_controller.page_cache_directory = RAILS_ROOT + "/public/cache"
  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
	config.gem "haml", :version => ">= 2.0.6"
	# config.gem "xml-simple"
	config.gem "mislav-will_paginate", :lib => "will_paginate", :version => ">= 2.3.6"
	config.gem  "thoughtbot-paperclip", :lib => "paperclip", :version => ">= 2.2.2"
	#config.gem "rspec", :lib =>"spec", :version => ">= 1.1.12"
	#config.gem "rspec-rails", :lib => "spec", :version => ">= 1.1.12"

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  #config.load_paths += %W( #{RAILS_ROOT}/vendor/gems/ )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Uncomment to use default local time.
  config.time_zone = 'Warsaw'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_untitled-7fb4c6_session',
    :secret      => '0beff2aa563f591c284a7c34e24f90e273d799d67e01a755dddfd43cfb619b82177205fc5b4236438d63ad356d2363f09a56e2336fae5b6bb0a9cf26c79993c4'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
end
