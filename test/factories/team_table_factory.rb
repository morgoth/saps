Factory.define :team_table do |f|
  f.association :league
  f.association :team
  f.points 0
  f.sets_lost 0
  f.sets_won 0
  f.matches_played 0
end