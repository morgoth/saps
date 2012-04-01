FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "team#{n}" }
  end
end
