require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  setup do
    @round = FactoryGirl.build(:round)
  end

  test "should not have all matches in round" do
    league = @round.league
    team_1 = FactoryGirl.create(:team)
    team_2 = FactoryGirl.create(:team)
    league.teams << [team_1, team_2]

    assert !@round.all_matches_in_round?
  end

  test "should have all matches in round" do
    league = @round.league
    team_1 = FactoryGirl.create(:team)
    team_2 = FactoryGirl.create(:team)
    league.teams << [team_1, team_2]

    FactoryGirl.create(:match, :round => @round, :home_team => team_1, :visitor_team => team_2)

    assert @round.all_matches_in_round?
  end

  test "should have all matches in round when nr of teams is odd" do
    league = @round.league
    team_1 = FactoryGirl.create(:team)
    team_2 = FactoryGirl.create(:team)
    team_3 = FactoryGirl.create(:team)
    league.teams << [team_1, team_2, team_3]

    FactoryGirl.create(:match, :round => @round, :home_team => team_1, :visitor_team => team_2)

    assert @round.all_matches_in_round?
  end

  test "should not have pause team if nr of teams is even and all possible matches not played" do
    league = @round.league
    team_1 = FactoryGirl.create(:team)
    team_2 = FactoryGirl.create(:team)
    league.teams << [team_1, team_2]

    assert_nil @round.pause_team
  end

  test "should not have pause team if nr of teams is even and all possible matches played" do
    league = @round.league
    team_1 = FactoryGirl.create(:team)
    team_2 = FactoryGirl.create(:team)
    league.teams << [team_1, team_2]

    FactoryGirl.create(:match, :round => @round, :home_team => team_1, :visitor_team => team_2)

    assert_nil @round.pause_team
  end

  test "should not have pause team if nr of teams is odd and all possible matches not played" do
    league = @round.league
    team_1 = FactoryGirl.create(:team)
    team_2 = FactoryGirl.create(:team)
    team_3 = FactoryGirl.create(:team)
    league.teams << [team_1, team_2, team_3]

    assert_nil @round.pause_team
  end

  test "should have pause team if nr of teams is odd and all possible matches played" do
    league = @round.league
    team_1 = FactoryGirl.create(:team)
    team_2 = FactoryGirl.create(:team)
    team_3 = FactoryGirl.create(:team)
    league.teams << [team_1, team_2, team_3]

    FactoryGirl.create(:match, :round => @round, :home_team => team_1, :visitor_team => team_2)

    assert_equal team_3, @round.pause_team
  end
end
