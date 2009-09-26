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
    self.score = '' if (home_team.name == 'Pause' || visitor_team.name == 'Pause')
    if !score.empty?
      home=TeamTable.find_by_league_id_and_team_id(self.round.league.id, home_team.id)
      visitor=TeamTable.find_by_league_id_and_team_id(self.round.league.id, visitor_team.id)
      points_calculation(home, visitor,'increment')
    end
  end

  def change_team_points_on_delete
    if !score.empty?
      home=TeamTable.find_by_league_id_and_team_id(self.round.league.id, home_team.id)
      visitor=TeamTable.find_by_league_id_and_team_id(self.round.league.id, visitor_team.id)
      points_calculation(home, visitor, 'decrement')
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
          if score.eql?('3:0') || score.eql?('3:1')
            #home_team.send(inc_dec,:points, 3)
            home_team.send(inc_dec,:points, 1)
            visitor_team.send(inc_dec,:points, 0)
          elsif score.eql?('3:2')
            #home_team.send(inc_dec,:points, 2)
            #visitor_team.send(inc_dec,:points, 1)
            home_team.send(inc_dec,:points, 1)
            visitor_team.send(inc_dec,:points, 0)
          elsif score.eql?('2:3')
            #home_team.send(inc_dec,:points, 1)
            #visitor_team.send(inc_dec,:points, 2)
            home_team.send(inc_dec,:points, 0)
            visitor_team.send(inc_dec,:points, 1)
          elsif score.eql?('0:3') || score.eql?('1:3')
            home_team.send(inc_dec,:points, 0)
            visitor_team.send(inc_dec,:points, 1)
            #visitor_team.send(inc_dec,:points, 3)
          end
      home_team.save!
      visitor_team.save!
  end

  def home_different_than_visitor
    errors.add_to_base("Home team must be different than visitor team") if home_team_id==visitor_team_id
  end

end
