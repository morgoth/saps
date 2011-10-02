require 'test_helper'

class TeamTableTest < ActiveSupport::TestCase
  setup do
    @league = Factory(:league, :three_zero => 3, :three_two => 2, :zero_three => 0, :two_three => 1)
    @team_table = Factory.build(:team_table, :league => @league)
  end

  test "set 0 to all attributes when zerofy is called" do
    @team_table.points = 4
    @team_table.sets_won = 3
    @team_table.sets_lost = 5
    @team_table.matches_played = 1
    @team_table.save!
    @team_table.send :zerofy
    assert_equal 0, @team_table.points
    assert_equal 0, @team_table.sets_won
    assert_equal 0, @team_table.sets_lost
    assert_equal 0, @team_table.matches_played
  end

  test "return good values when calculate points is called" do
    @team_table.save!
    actual = @team_table.send(:calculate_points_for_home_team, "3:2")
    assert_equal 2, actual
    actual = @team_table.send(:calculate_points_for_home_team, "3:1")
    assert_equal 3, actual
    actual = @team_table.send(:calculate_points_for_home_team, "3:0")
    assert_equal 3, actual
    actual = @team_table.send(:calculate_points_for_visitor_team, "3:0")
    assert_equal 0, actual
  end
end

class TeamTableRecalculateTest < ActiveSupport::TestCase
  setup do
    @league = Factory(:league, :three_zero => 3, :three_two => 2, :zero_three => 0, :two_three => 1)
    @team_1 = Factory(:team)
    @team_2 = Factory(:team)
    @team_table_1 = Factory(:team_table, :team => @team_1, :league => @league)
    @team_table_2 = Factory(:team_table, :team => @team_2, :league => @league)
    @round = Factory(:round, :league => @league)
  end

  test "should recalculate team points in given match" do
    Factory(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => "3:0")
    @team_table_1.recalculate!
    @team_table_2.recalculate!
    assert_equal 3, @team_table_1.points
    assert_equal 0, @team_table_2.points
  end

  test "should recalculate team points when teams are switched in match" do
    match = Factory(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => "3:0")
    @team_table_1.recalculate!
    @team_table_2.recalculate!
    assert_equal 3, @team_table_1.points
    assert_equal 0, @team_table_2.points
    match.update_attributes!(:home_team => @team_2, :visitor_team => @team_1)
    @team_table_1.recalculate!
    @team_table_2.recalculate!
    assert_equal 3, @team_table_2.points
    assert_equal 0, @team_table_1.points
  end

  test "should recalculate team points when score is changed" do
    match = Factory(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => "3:0")
    @team_table_1.recalculate!
    @team_table_2.recalculate!
    match.update_attributes(:score => "2:3")
    @team_table_1.recalculate!
    @team_table_2.recalculate!
    assert_equal 2, @team_table_2.points
    assert_equal 1, @team_table_1.points
  end
end
