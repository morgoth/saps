require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  setup { @league = Factory.build(:league) }

  test "should not be valid when second league is active" do
    @league.active = true
    @league.save!
    league_2 = Factory.build(:league, :active => true)
    assert league_2.invalid?
  end

  test "should be valid with 2 leagues not active" do
    @league.active = false
    @league.save!
    league_2 = Factory.build(:league, :active => false)
    assert league_2.valid?
  end

  test "should be valid when changing from active to not active" do
    Factory(:league, :active => false)
    @league.active = true
    @league.save!
    @league.active = false
    assert @league.valid?
  end
end
