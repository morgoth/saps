require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  setup do
    @league = FactoryGirl.create(:league)
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team)
    @league.teams << [@team_1, @team_2]
    @round = FactoryGirl.create(:round, :league => @league)
  end

  test "should return matches with score calling with_score scope" do
    FactoryGirl.create(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => nil)
    FactoryGirl.create(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => '')
    match = FactoryGirl.create(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => "3:0")
    assert_equal [match], Match.with_score.all
  end

  test "should return matches with given team calling with_team scope" do
    match_1 = FactoryGirl.create(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => nil)
    team_3 = FactoryGirl.create(:team)
    FactoryGirl.create(:team_table, :team => team_3, :league => @league)
    FactoryGirl.create(:match, :round => @round, :home_team => @team_2, :visitor_team => team_3)
    match_2 = FactoryGirl.create(:match, :round => @round, :home_team => @team_2, :visitor_team => @team_1)
    assert_equal [match_1, match_2], Match.with_team(@team_1).all
  end

  test "should calculate team tables after save" do
    @league.update_attribute(:three_two, 2)
    @league.update_attribute(:two_three, 1)
    team_table_1 = @league.team_tables.where(:team_id => @team_1).first
    team_table_2 = @league.team_tables.where(:team_id => @team_2).first
    assert_equal 0, team_table_1.points
    assert_equal 0, team_table_2.points
    FactoryGirl.create(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => "3:2")
    assert_equal 2, team_table_1.reload.points
    assert_equal 1, team_table_2.reload.points
  end

  test "should calculate team tables after destroy" do
    @league.update_attribute(:three_two, 2)
    @league.update_attribute(:two_three, 1)
    team_table_1 = @league.team_tables.where(:team_id => @team_1).first
    team_table_2 = @league.team_tables.where(:team_id => @team_2).first
    match = FactoryGirl.create(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => "3:2")
    assert_equal 2, team_table_1.reload.points
    assert_equal 1, team_table_2.reload.points
    match.destroy
    assert_equal 0, team_table_1.reload.points
    assert_equal 0, team_table_2.reload.points
  end
end
