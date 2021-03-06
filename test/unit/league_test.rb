require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  setup { @league = FactoryGirl.build(:league) }

  test "should not be valid when second league is active" do
    @league.active = true
    @league.save!
    league_2 = FactoryGirl.build(:league, :active => true)
    assert league_2.invalid?
  end

  test "should be valid with 2 leagues not active" do
    @league.active = false
    @league.save!
    league_2 = FactoryGirl.build(:league, :active => false)
    assert league_2.valid?
  end

  test "should be valid when changing from active to not active" do
    FactoryGirl.create(:league, :active => false)
    @league.active = true
    @league.save!
    @league.active = false
    assert @league.valid?
  end

  test "should have pause if nr of teams is odd" do
    @league.save!
    3.times { @league.teams << FactoryGirl.create(:team) }
    assert @league.with_pause?
  end

  test "should not have pause if nr of teams is even" do
    @league.save!
    2.times { @league.teams << FactoryGirl.create(:team) }
    assert !@league.with_pause?
  end
end
