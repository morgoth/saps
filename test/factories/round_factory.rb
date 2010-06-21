Factory.define :round do |f|
  f.association :league
  f.sequence(:name) { |n| "round#{n}" }
end
