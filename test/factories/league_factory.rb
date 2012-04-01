FactoryGirl.define do
  factory :league do
    sequence(:name) { |n| "league#{n}" }
    three_zero 3
    three_two 2
    zero_three 0
    two_three 1
    active false
  end
end
