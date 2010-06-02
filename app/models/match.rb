class Match < ActiveRecord::Base
  belongs_to :round
  belongs_to :home_team, :class_name => "Team", :foreign_key => "home_team_id"
  belongs_to :visitor_team, :class_name => "Team", :foreign_key => 'visitor_team_id'
  has_one :league, :through => :round

  before_validation :empty_score_if_paused
  after_save :home_team_table_recalculate!, :visitor_team_table_recalculate!
  after_destroy :home_team_table_recalculate!, :visitor_team_table_recalculate!

  AVAILABLE_SCORES = %w{3:0 3:1 3:2 0:3 1:3 2:3}

  validates_presence_of :round_id
  validates_inclusion_of :score, :in => AVAILABLE_SCORES, :message => "score format - set:set", :allow_blank => true
  validate :home_different_than_visitor

  scope :recent, order("updated_at DESC").limit(10)

  private

  def empty_score_if_paused
    self.score = '' if (home_team.name == 'Pause' || visitor_team.name == 'Pause')
  end

  def home_team_table_recalculate!
    TeamTable.find_by_league_id_and_team_id(league.id, home_team.id).recalculate!
  end

  def visitor_team_table_recalculate!
    TeamTable.find_by_league_id_and_team_id(league.id, visitor_team.id).recalculate!
  end

  def home_different_than_visitor
    errors.add_to_base("Home team must be different than visitor team") if home_team_id == visitor_team_id
  end
end
