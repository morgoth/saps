require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  setup { @player = Factory.build(:player) }

  test "return active players" do
    @player.active = true
    @player.save!
    Factory(:player, :active => false)
    assert_equal [@player], Player.active.all
  end

  test "defalut value of active is false" do
    player = Player.new
    assert_equal false, player.active
  end
end
