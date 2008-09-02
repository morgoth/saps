class Match < ActiveRecord::Base
	belongs_to :round
	belongs_to :home_team, :class_name => "Team", :foreign_key => "home_team_id"
	belongs_to :visitor_team, :class_name => "Team", :foreign_key => 'visitor_team_id'
	before_create :change_team_points_on_create
	before_update :change_team_point_on_update
	
	
	
	private
	def change_team_points_on_create
		if !score.empty?
				home_team.sets_won+=score[0,1].to_i
				home_team.sets_lost+=score[-1,1].to_i
				visitor_team.sets_won+=score[-1,1].to_i
				visitor_team.sets_lost+=score[0,1].to_i
				home_team.matches_played+=1
				visitor_team.matches_played+=1
				points_calculation(home_team, visitor_team)
			home_team.save!
			visitor_team.save!
		end
	end
	
	def change_team_points_on_update
		score='0:0' if score.empty?

			
		
	end
	
	
	
	
	def points_calculation(home_team, visitor_team)
		if score=='3:0' || '3:1'
			home_team.points+=3
			visitor_team.points+=1
		elsif score == '3:2'
			home_team.points+=2
			visitor_team.points+=1
		elsif score =='2:3'
			home_team.points+=1
			visitor_team.points+=2
		elsif score =='0:3' || '1:3'
			home_team.points+=1
			visitor_team.points+=3
		end
	end
	
end
