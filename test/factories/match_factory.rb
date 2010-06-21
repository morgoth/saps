Factory.define :match do |f|
  f.association :round
  f.association :home_team, :factory => :team
  f.association :visitor_team, :factory => :team
  f.score "3:0"
end
