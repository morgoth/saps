require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Player do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :birth_date => Date.today,
      :height => "1",
      :position => "value for position",
      :about => "value for about",
      :active_player => false
    }
  end

  it "should create a new instance given valid attributes" do
    Player.create!(@valid_attributes)
  end
end
