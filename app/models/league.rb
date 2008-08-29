class League < ActiveRecord::Base
	has_many :rounds, :dependent => :destroy
	validates_presence_of :name
end
