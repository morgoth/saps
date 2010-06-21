class TeamTable < ActiveRecord::Base
  belongs_to :league
  belongs_to :team

  scope :sorted_table, order('points DESC, sets_won-sets_lost DESC')

  def recalculate!
    zerofy
    matches = league.matches.all(:conditions => ['home_team_id=? OR visitor_team_id=?', team.id, team.id])
    matches.reject! { |m| m.score.blank? }
    matches.each do |match|
      self.matches_played += 1
      if match.home_team == team
        self.sets_won += match.score[0,1].to_i
        self.sets_lost += match.score[-1,1].to_i
        self.points += calculate_points_for_home_team(match.score)
      elsif match.visitor_team == team
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
    if score.eql?('3:0') || score.eql?('3:1')
      league.three_zero
    elsif score.eql?('3:2')
      league.three_two
    elsif score.eql?('2:3')
      league.two_three
    elsif score.eql?('0:3') || score.eql?('1:3')
      league.zero_three
    end
  end

  def calculate_points_for_visitor_team(score)
    if score.eql?('3:0') || score.eql?('3:1')
      league.zero_three
    elsif score.eql?('3:2')
      league.two_three
    elsif score.eql?('2:3')
      league.three_two
    elsif score.eql?('0:3') || score.eql?('1:3')
      league.three_zero
    end
  end
end