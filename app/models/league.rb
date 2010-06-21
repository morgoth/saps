class League < ActiveRecord::Base
  has_many :rounds, :dependent => :destroy
  has_many :team_tables
  has_many :teams, :through => :team_tables
  has_many :matches, :through => :rounds, :order => "updated_at DESC"

  validates :name, :presence => true, :uniqueness => true
  validate :only_one_league_active, :if => :active?
  validates_associated :team_tables
  validates_numericality_of :three_zero, :three_two, :zero_three, :two_three,
                            :only_integer => true, :greater_than_or_equal => 0

  scope :active, where(:active => true).limit(1)

  private

  def only_one_league_active
    leagues = League.where("leagues.id != ?", id.to_i).where(:active => true)
    errors.add(:base, "Only one league can be active") if leagues.any?
  end
end
