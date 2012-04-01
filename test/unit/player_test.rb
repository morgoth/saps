require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  setup { @player = FactoryGirl.build(:player) }

  test "return active players" do
    @player.active = true
    @player.save!
    FactoryGirl.create(:player, :active => false)
    assert_equal [@player], Player.active.all
  end

  test "defalut value of active is false" do
    player = Player.new
    assert_equal false, player.active
  end
end
