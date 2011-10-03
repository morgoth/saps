class Round < ActiveRecord::Base
  belongs_to :league
  has_many :matches, :dependent => :destroy, :order => :hour

  validates :name, :presence => true, :uniqueness => {:scope => :league_id}

  def pause_team
    if league.with_pause? && all_matches_in_round?
      (league.teams - matches.map { |m| [m.home_team, m.visitor_team] }.flatten).first
    else
      nil
    end
  end

  def all_matches_in_round?
    league.teams.count / 2 <= matches.count
  end
end
