FactoryGirl.define do
  factory :round do
    association :league
    sequence(:name) { |n| "round#{n}" }
  end
end
