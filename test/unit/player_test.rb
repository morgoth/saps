require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  context "Player" do
    setup { @player = Factory.build(:player) }

    should "return active players" do
      @player.active_player = true
      @player.save!
      Factory(:player, :active_player => nil)
      assert_equal [@player], Player.active.all
    end

    should "return not active players if column is set to null" do
      @player.active_player = nil
      @player.save!
      player_2 = Factory(:player, :active_player => false)
      Factory(:player, :active_player => true)
      assert_same_elements [@player, player_2], Player.not_active.all
    end
  end
end