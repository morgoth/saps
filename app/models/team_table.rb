class TeamTable < ActiveRecord::Base
  belongs_to :league
  belongs_to :team
  
end