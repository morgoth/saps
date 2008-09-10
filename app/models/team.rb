class Team < ActiveRecord::Base
  #if nr of teams is odd, create team named Pause
    validates_presence_of :name
end
