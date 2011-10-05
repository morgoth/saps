class Match < ActiveRecord::Base
  SCORES = %w{3:0 3:1 3:2 0:3 1:3 2:3}

  belongs_to :round
  belongs_to :home_team, :class_name => "Team"
  belongs_to :visitor_team, :class_name => "Team"
  has_one :league, :through => :round

  after_save :calculate_team_tables!
  after_destroy :calculate_team_tables!

  validates_presence_of :round, :home_team, :visitor_team
  validates_inclusion_of :score, :in => SCORES, :message => "score format - set:set", :allow_blank => true
  validate :home_different_than_visitor

  scope :recent, order("updated_at DESC").limit(10)
  scope :with_score, where("matches.score != '' OR matches.score != NULL")
  scope :with_team, lambda { |team| where(['home_team_id = :team OR visitor_team_id = :team', :team => team]) }

  private

  def calculate_team_tables!
    league.team_tables.where(:team_id => [home_team, visitor_team]).each(&:calculate!)
  end

  def home_different_than_visitor
    errors.add(:base, "Home team must be different than visitor team") if home_team == visitor_team
  end
end
