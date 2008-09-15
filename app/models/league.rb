class League < ActiveRecord::Base
  has_many :rounds, :dependent => :destroy
  has_and_belongs_to_many :teams
  has_many :matches, :through => :rounds
  validates_presence_of :name
  validates_uniqueness_of :name
  validate :only_one_league_active
  
  
  
  private
  def only_one_league_active
    if active == true
      League.all.each do |league|
        errors.add_to_base "Only one league can be active" if league.active == true
      end
    end       
  end
  
end
