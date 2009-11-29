class Team < ActiveRecord::Base
  # if nr of teams is odd, create team named Pause
  has_many :team_tables
  has_many :leagues, :through => :team_tables
  validates_uniqueness_of :name

  def statistics
    matches_played = team_tables.sum(:matches_played)
    sets_won = team_tables.sum(:sets_won)
    sets_lost = team_tables.sum(:sets_lost)
    { :played => matches_played, :won => sets_won, :lost => sets_lost }
  end
end