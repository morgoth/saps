class League < ActiveRecord::Base
  has_many :rounds, :dependent => :destroy
  has_many :team_tables
  has_many :teams, :through => :team_tables
  has_many :matches, :through => :rounds, :order => "updated_at DESC"
  validates_presence_of :name
  validates_uniqueness_of :name
  validate :only_one_league_active
  validates_associated :team_tables
	named_scope :active, :conditions => {:active => true }, :limit => 1

  private
  def only_one_league_active
    if active == true
      leagues = League.all.reject { |league| league[:id] == id }
			leagues.each do |league|
        errors.add_to_base "Only one league can be active" if league.active == true
      end
    end
  end

end
