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

    should "return not active players" do
      @player.active_player = nil
      @player.save!
      Factory(:player, :active_player => true)
      assert_equal [@player], Player.not_active.all
    end
  end
end