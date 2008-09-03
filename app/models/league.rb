class League < ActiveRecord::Base
  has_many :rounds, :dependent => :destroy
  #has_many :matches, :through => :rounds
  validates_presence_of :name
  
  def testuj

  end
  
  
end
