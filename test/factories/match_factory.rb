FactoryGirl.define do
  factory :match do
    association :round
    association :home_team, :factory => :team
    association :visitor_team, :factory => :team
    score "3:0"
  end
end
