Factory.define :team do |f|
  f.sequence(:name) { |n| "team#{n}" }
end