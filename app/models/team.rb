class Team < ActiveRecord::Base
  #if nr of teams is odd, create team named Pause
  has_and_belongs_to_many :leagues
    validates_presence_of :name
end
