source "https://rubygems.org"

ruby "2.0.0"

gem "rails", "~> 3.2.11"

gem "haml"
gem "will_paginate", ">= 3.0"
gem "picasa", ">= 0.4.2"
gem "authlogic", ">= 3.0"
gem "simple_form", ">= 1.2.2"
gem "RedCloth", require: "redcloth"
gem "jquery-rails"

group :assets do
  gem "compass-rails"
  gem "sass-rails", "~> 3.2.0"
  gem "uglifier"
end

group :test do
  gem "factory_girl_rails"
end

group :test, :development do
  gem "sqlite3"
end

group :production do
  gem "pg"
  gem "thin"
end
