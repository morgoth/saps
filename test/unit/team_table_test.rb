require 'test_helper'

class TeamTableTest < ActiveSupport::TestCase

  context "Team table" do
    setup do
      @team_table = Factory.build(:team_table)
    end

    should "set 0 to all attributes when zerofy is called" do
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

    should "return good values when calculate points is called" do
      league = @team_table.league
      league.three_two = 2
      league.zero_three = 0
      league.save!
      @team_table.save!
      actual = @team_table.send(:calculate_points_for_home_team, "3:2")
      assert_equal 2, actual
      actual = @team_table.send(:calculate_points_for_visitor_team, "3:0")
      assert_equal 0, actual
    end
  end
end