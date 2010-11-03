class Achievement < ActiveRecord::Base
  validates_presence_of :played_at, :description

  default_scope :order => "played_at DESC"
end
