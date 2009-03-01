require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Match do
	before(:each) do
			@match = Factory.build(:match)
	end

	%w{3:0 3:1 3:2 0:3 1:3 2:3}.each do |score|
		it "should be valid with score #{score}" do 
			@match.score = score
			@match.should be_valid
		end
	end
	
	it "should be valid with empty score" do
		@match.score = ''
		@match.should be_valid
	end
	
	it "should be valid when home team is different than visitor team" do 
		@match.should be_valid
	end
	
	it "should not be valid when home team is equal visitor team" do 
		@match.visitor_team_id = @match.home_team_id
		@match.should_not be_valid
	end
end
