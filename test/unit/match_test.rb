require 'test_helper'

class MatchTest < ActiveSupport::TestCase

  setup do
    @league = Factory(:league)
    @team_1 = Factory(:team)
    @team_2 = Factory(:team)
    Factory(:team_table, :team => @team_1, :league => @league)
    Factory(:team_table, :team => @team_2, :league => @league)
    @round = Factory(:round, :league => @league)
  end

  test "should return matches with score calling with_score scope" do
    Factory(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => nil)
    Factory(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => '')
    match = Factory(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => "3:0")
    assert_equal [match], Match.with_score.all
  end

  test "should return matches with given team calling with_team scope" do
    match_1 = Factory(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => nil)
    team_3 = Factory(:team)
    Factory(:team_table, :team => team_3, :league => @league)
    Factory(:match, :round => @round, :home_team => @team_2, :visitor_team => team_3)
    match_2 = Factory(:match, :round => @round, :home_team => @team_2, :visitor_team => @team_1)
    assert_equal [match_1, match_2], Match.with_team(@team_1).all
  end

  test "should empty score if team is pause" do
    pause = Factory(:team, :name => "Pause")
    Factory(:team_table, :team => pause, :league => @league)
    match = Factory(:match, :round => @round, :home_team => pause, :visitor_team => @team_2, :score => "3:1")
    assert_equal "", match.score
  end
end
