class Match < ActiveRecord::Base
  belongs_to :round
  belongs_to :home_team, :class_name => "Team", :foreign_key => "home_team_id"
  belongs_to :visitor_team, :class_name => "Team", :foreign_key => 'visitor_team_id'
  before_create :change_team_points_on_create
  before_update :change_team_points_on_update
  before_destroy :change_team_points_on_delete
  
  validates_inclusion_of :score, :in => AVAILABLE_SCORES, :message => "format wyniku - set:set"
  #AVAILABLE_SCORES placed in environment.rb
  
  private
  def change_team_points_on_create
    if !score.empty?
      points_calculation(home_team, visitor_team,'increment')
      home_team.save!
      visitor_team.save!
    end
  end
  
  def change_team_points_on_update
    if !score.empty?
      points_calculation(home_team, visitor_team,'increment')
      home_team.save!
      visitor_team.save!  
    end  
  end
  
  def change_team_points_on_delete
        points_calculation(home_team, visitor_team, 'decrement')
        home_team.save!
        visitor_team.save!
    
  end  
  
  
  
  def points_calculation(home_team, visitor_team, inc_dec)
        home_team.send(inc_dec, :sets_won, score[0,1].to_i)
        home_team.send(inc_dec, :sets_lost, score[-1,1].to_i)
        visitor_team.send(inc_dec, :sets_won, score[-1,1].to_i)
        visitor_team.send(inc_dec, :sets_lost, score[0,1].to_i)
        home_team.send(inc_dec, :matches_played, 1)
        visitor_team.send(inc_dec, :matches_played, 1)

    if score=='3:0' || '3:1'
      home_team.send(inc_dec,:points, 3) #Obiekt.send('metoda',argumenty)
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
  
end
