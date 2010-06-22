class Match < ActiveRecord::Base
  belongs_to :round
  belongs_to :home_team, :class_name => "Team"
  belongs_to :visitor_team, :class_name => "Team"
  has_one :league, :through => :round

  before_validation :empty_score_if_paused
  after_save :home_team_table_recalculate!, :visitor_team_table_recalculate!
  after_destroy :home_team_table_recalculate!, :visitor_team_table_recalculate!

  AVAILABLE_SCORES = %w{3:0 3:1 3:2 0:3 1:3 2:3}

  validates_presence_of :round_id
  validates_inclusion_of :score, :in => AVAILABLE_SCORES, :message => "score format - set:set", :allow_blank => true
  validate :home_different_than_visitor

  scope :recent, order("updated_at DESC").limit(10)
  scope :with_score, where("matches.score != '' OR matches.score != NULL")
  scope :with_team, lambda { |team| where(['home_team_id=? OR visitor_team_id=?', team, team])}

  private

  def empty_score_if_paused
    self.score = '' if (home_team.try(:name) == 'Pause' || visitor_team.try(:name) == 'Pause')
  end

  def home_team_table_recalculate!
    TeamTable.where(:league_id => league.id).where(:team_id => home_team.id).first.recalculate!
  end

  def visitor_team_table_recalculate!
    TeamTable.where(:league_id => league.id).where(:team_id => visitor_team.id).first.recalculate!
  end

  def home_different_than_visitor
    errors.add(:base, "Home team must be different than visitor team") if home_team_id == visitor_team_id
  end
end
