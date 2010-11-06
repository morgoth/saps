class Achievement < ActiveRecord::Base
  validates_presence_of :played_at, :description, :place
  validates_numericality_of :place, :only_integer => true, :greater_than => 0

  default_scope :order => "played_at DESC"
end
