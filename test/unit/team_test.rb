require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  setup { @team = Factory.build(:team) }

  test "check if team is pause" do
    @team.name = "Pause"
    assert @team.pause?
    @team.name = "great team"
    assert !@team.pause?
  end

  test "return teams without pause" do
    @team.name = "Pause"
    @team.save!
    team = Factory(:team, :name => "great team")
    assert_equal [team], Team.without_pause.all
  end
end
