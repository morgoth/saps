FactoryGirl.define do
  factory :team_table do
    association :league
    association :team
    points 0
    sets_lost 0
    sets_won 0
    matches_played 0
  end
end
