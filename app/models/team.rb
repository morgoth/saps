class Team < ActiveRecord::Base
  #if nr of teams is odd, create team named Pause
  has_and_belongs_to_many :leagues
    validates_presence_of :name


  def statistics(matches)
    matches.each do |match|
      if !match.score.empty?
        if match.home_team.eql?(name)
          score[0,1].to_i
        else
        
        end
      end
    end
  end
    
end
