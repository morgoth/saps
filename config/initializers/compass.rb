require "fileutils"
FileUtils.mkdir_p(Rails.root.join("tmp", "stylesheets", "compiled"))

require 'compass'
require 'compass/app_integration/rails'
Compass::AppIntegration::Rails.initialize!
