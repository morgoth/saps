class Team < ActiveRecord::Base
  has_many :team_tables
  has_many :leagues, :through => :team_tables

  validates :name, :presence => true, :uniqueness => true

  def statistics
    {:played => matches_played, :won => sets_won, :lost => sets_lost}
  end

  def matches_played
    team_tables.sum(:matches_played)
  end

  def sets_won
    team_tables.sum(:sets_won)
  end

  def sets_lost
    team_tables.sum(:sets_lost)
  end
end
