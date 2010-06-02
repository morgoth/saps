source "http://rubygems.org"

gem "rails", :git => "http://github.com/rails/rails.git"

gem "haml", ">=3.0.10"
gem "compass", ">=0.10.2"
gem "xml-simple", :require => "xmlsimple"
gem "will_paginate", :git => "http://github.com/mislav/will_paginate.git", :branch => "rails3"
gem "picasa", ">=0.1.9"
gem "authlogic", :git => "http://github.com/odorcicd/authlogic.git", :branch => "rails3"
gem "simple_form", ">= 1.2.0"
gem "RedCloth", :require => "redcloth"
# gem "hoptoad_notifier"
gem "sqlite3-ruby", :require => "sqlite3", :group => [:development, :test]

group :test do
  gem "test-unit", ">=2.0", :require => "test/unit"
  gem "factory_girl", :git => "http://github.com/thoughtbot/factory_girl.git", :branch => "fixes_for_rails3"
  gem "rr"
end

group :production do
  gem "pg"
end
