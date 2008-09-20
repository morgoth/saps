class Team < ActiveRecord::Base
  #if nr of teams is odd, create team named Pause
  has_many :team_tables
  has_many :leagues, :through => :team_tables
    validates_presence_of :name


  def statistics
    matches_played, sets_won, sets_lost = 0,0,0
    self.team_tables.each do |table|
      matches_played+=table.matches_played
      sets_won+=table.sets_won
      sets_lost+=table.sets_lost
    end
    stats={:played=>matches_played, :won=>sets_won, :lost=>sets_lost}
    
  end
    
end