FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "secret"
    password_confirmation { |u| u.password }
  end
end
