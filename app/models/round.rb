class Round < ActiveRecord::Base
	belongs_to :league
	has_many :matches
end
