class Round < ActiveRecord::Base
  belongs_to :league
  has_many :matches, :dependent => :destroy, :order => :hour
  
  validates_presence_of :name
  #validates_uniqueness_of :name
end
