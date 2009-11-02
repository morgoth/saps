class TeamTable < ActiveRecord::Base
  belongs_to :league
  belongs_to :team

  named_scope :sorted_table, :order => 'points DESC, sets_won-sets_lost DESC'
end