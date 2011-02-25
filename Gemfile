source :rubygems

gem "rails", "~> 3.0.5.rc1"

gem "haml", ">=3.0.18"
gem "compass", ">=0.10.2"
gem "will_paginate", ">= 3.0.pre2"
gem "picasa", ">=0.1.9"
gem "authlogic", :git => "http://github.com/odorcicd/authlogic.git", :branch => "rails3"
gem "simple_form", ">= 1.2.2"
gem "RedCloth", "=4.2.3", :require => "redcloth"
# gem "hoptoad_notifier"
gem "sqlite3", :group => [:development, :test]

group :test do
  gem "test-unit", ">=2.0", :require => "test/unit"
  gem "factory_girl_rails"
end

group :production do
  gem "pg"
end
