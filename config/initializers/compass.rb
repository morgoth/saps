require "fileutils"
FileUtils.mkdir_p(Rails.root.join("tmp", "stylesheets", "compiled"))

require 'compass'
Compass.add_project_configuration(Rails.root.join("config", "compass.rb"))
Compass.configure_sass_plugin!
Compass.handle_configuration_change!
