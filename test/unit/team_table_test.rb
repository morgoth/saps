require 'test_helper'

class TeamTableTest < ActiveSupport::TestCase
  setup do
    @league = FactoryGirl.create(:league, :three_zero => 3, :three_two => 2, :zero_three => 0, :two_three => 1)
    @team_table = FactoryGirl.build(:team_table, :league => @league)
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
    actual = @team_table.send(:home_team_points, "3:2")
    assert_equal 2, actual
    actual = @team_table.send(:home_team_points, "3:1")
    assert_equal 3, actual
    actual = @team_table.send(:home_team_points, "3:0")
    assert_equal 3, actual
    actual = @team_table.send(:visitor_team_points, "3:0")
    assert_equal 0, actual
  end
end

class TeamTableCalculateTest < ActiveSupport::TestCase
  setup do
    @league = FactoryGirl.create(:league, :three_zero => 3, :three_two => 2, :zero_three => 0, :two_three => 1)
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team)
    @team_table_1 = FactoryGirl.create(:team_table, :team => @team_1, :league => @league)
    @team_table_2 = FactoryGirl.create(:team_table, :team => @team_2, :league => @league)
    @round = FactoryGirl.create(:round, :league => @league)
  end

  test "should calculate team points in given match" do
    FactoryGirl.create(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => "3:0")
    @team_table_1.calculate!
    @team_table_2.calculate!
    assert_equal 3, @team_table_1.points
    assert_equal 0, @team_table_2.points
  end

  test "should calculate team points when teams are switched in match" do
    match = FactoryGirl.create(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => "3:0")
    @team_table_1.calculate!
    @team_table_2.calculate!
    assert_equal 3, @team_table_1.points
    assert_equal 0, @team_table_2.points
    match.update_attributes!(:home_team => @team_2, :visitor_team => @team_1)
    @team_table_1.calculate!
    @team_table_2.calculate!
    assert_equal 3, @team_table_2.points
    assert_equal 0, @team_table_1.points
  end

  test "should calculate team points when score is changed" do
    match = FactoryGirl.create(:match, :round => @round, :home_team => @team_1, :visitor_team => @team_2, :score => "3:0")
    @team_table_1.calculate!
    @team_table_2.calculate!
    match.update_attributes(:score => "2:3")
    @team_table_1.calculate!
    @team_table_2.calculate!
    assert_equal 2, @team_table_2.points
    assert_equal 1, @team_table_1.points
  end
end

class TeamTableOrderTest < ActiveSupport::TestCase
  setup do
    @league = FactoryGirl.create(:league, :three_zero => 3, :three_two => 2, :zero_three => 0, :two_three => 1)
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team)
    @team_table_1 = FactoryGirl.create(:team_table, :team => @team_1, :league => @league)
    @team_table_2 = FactoryGirl.create(:team_table, :team => @team_2, :league => @league)
    @round = FactoryGirl.create(:round, :league => @league)
  end

  test "should order by points" do
    @team_table_1.update_attributes(:points => 3)
    @team_table_2.update_attributes(:points => 2)
    assert_equal [@team_table_1, @team_table_2], @league.team_tables.sorted_table.all
  end

  test "should order by sets difference when points are equal" do
    @team_table_1.update_attributes(:points => 4, :sets_won => 4, :sets_lost => 1)
    @team_table_2.update_attributes(:points => 4, :sets_won => 3, :sets_lost => 1)
    assert_equal [@team_table_1, @team_table_2], @league.team_tables.sorted_table.all
  end

  test "should order by won_sets when sets difference and points are equal" do
    @team_table_1.update_attributes(:points => 4, :sets_won => 4, :sets_lost => 1)
    @team_table_2.update_attributes(:points => 4, :sets_won => 3, :sets_lost => 0)
    assert_equal [@team_table_1, @team_table_2], @league.team_tables.sorted_table.all
  end
end
