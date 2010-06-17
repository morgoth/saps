class Round < ActiveRecord::Base
  belongs_to :league
  has_many :matches, :dependent => :destroy, :order => :hour

  validates :name, :presence => true, :uniqueness => { :scope => :league_id }
end
