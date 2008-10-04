require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Match do
  AVAILABLE_SCORES = %w{3:0 3:1 3:2 0:3 1:3 2:3}
  AVAILABLE_SCORES << ''
  before(:each) do
    @valid_attributes = {
    :round_id => 1, :home_team_id => 1, :visitor_team_id => 2, :score => ''
    }
    @match=Match.new @valid_attributes
    @team1=Team.create({:id=>1, :name=>'one'})
    @team2= Team.create({:id=>2, :name=>'two'})
end
it "should be valid with valid score" do 
  AVAILABLE_SCORES.each do |score|
    @match.score= score  
    @match.should be_valid
  end
end



it "should be valid when home team is different than visitor team" do 
  @match=Match.new({:round_id => 1, :home_team_id => 1, :visitor_team_id => 2, :score => ''})
  @match.should be_valid
end

it "should not be valid when home team is equal visitor team" do 
  @match.visitor_team_id = 1
  @match.should_not be_valid
end



end