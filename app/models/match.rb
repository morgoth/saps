class Match < ActiveRecord::Base
  belongs_to :round
  belongs_to :home_team, :class_name => "Team", :foreign_key => "home_team_id"
  belongs_to :visitor_team, :class_name => "Team", :foreign_key => 'visitor_team_id'
  
  before_save :change_team_points_on_save
  before_destroy :change_team_points_on_delete
 
  AVAILABLE_SCORES = %w{3:0 3:1 3:2 0:3 1:3 2:3}
  AVAILABLE_SCORES << '' 
  
  validates_presence_of :round_id
  validates_inclusion_of :score, :in => AVAILABLE_SCORES, :message => "score format - set:set"
  validate :home_different_than_visitor
  
  
  private
  def change_team_points_on_save
    if !score.empty?
      points_calculation(home_team, visitor_team,'increment')
      home_team.save!
      visitor_team.save!
    end
  end
  
  def change_team_points_on_delete
    if !score.empty?
        points_calculation(home_team, visitor_team, 'decrement')
        home_team.save!
        visitor_team.save!
    end
  end  
  
  def points_calculation(home_team, visitor_team, inc_dec)
      #Object.send('method',args)
        home_team.send(inc_dec, :sets_won, score[0,1].to_i)
        home_team.send(inc_dec, :sets_lost, score[-1,1].to_i)
        visitor_team.send(inc_dec, :sets_won, score[-1,1].to_i)
        visitor_team.send(inc_dec, :sets_lost, score[0,1].to_i)
        home_team.send(inc_dec, :matches_played, 1)
        visitor_team.send(inc_dec, :matches_played, 1)
          if score=='3:0' || '3:1'
            home_team.send(inc_dec,:points, 3)
            visitor_team.send(inc_dec,:points, 1)
          elsif score == '3:2'
            home_team.send(inc_dec,:points, 2)
            visitor_team.send(inc_dec,:points, 1)
          elsif score =='2:3'
            home_team.send(inc_dec,:points, 1)
            visitor_team.send(inc_dec,:points, 2)
          elsif score =='0:3' || '1:3'
            home_team.send(inc_dec,:points, 1)
            visitor_team.send(inc_dec,:points, 3)
          end
  end
  
  def home_different_than_visitor
    errors.add_to_base("Home team must be different than visitor team") if home_team_id==visitor_team_id
  end
  
end
