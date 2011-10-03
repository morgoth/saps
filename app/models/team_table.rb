class TeamTable < ActiveRecord::Base
  belongs_to :league
  belongs_to :team

  scope :sorted_table, order('points DESC, sets_won - sets_lost DESC, sets_won DESC')

  def recalculate!
    zerofy
    matches = league.matches.with_score.with_team(team)
    matches.each do |match|
      self.matches_played += 1
      if match.home_team_id == team.id
        self.sets_won += match.score[0,1].to_i
        self.sets_lost += match.score[-1,1].to_i
        self.points += calculate_points_for_home_team(match.score)
      elsif match.visitor_team_id == team.id
        self.sets_won += match.score[-1,1].to_i
        self.sets_lost += match.score[0,1].to_i
        self.points += calculate_points_for_visitor_team(match.score)
      end
    end
    save!
  end

  private

  def zerofy
    self.points = self.sets_won = self.sets_lost = self.matches_played = 0
  end

  def calculate_points_for_home_team(score)
    case score
    when "3:0", "3:1"
      league.three_zero
    when "3:2"
      league.three_two
    when "2:3"
      league.two_three
    when "0:3", "1:3"
      league.zero_three
    end
  end

  def calculate_points_for_visitor_team(score)
    case score
    when "3:0", "3:1"
      league.zero_three
    when "3:2"
      league.two_three
    when "2:3"
      league.three_two
    when "0:3", "1:3"
      league.three_zero
    end
  end
end
