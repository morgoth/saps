require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/players/index.html.erb" do
  include PlayersHelper
  
  before(:each) do
    assigns[:players] = [
      stub_model(Player,
        :name => "value for name",
        :height => "1",
        :position => "value for position",
        :about => "value for about",
        :active_player => false
      ),
      stub_model(Player,
        :name => "value for name",
        :height => "1",
        :position => "value for position",
        :about => "value for about",
        :active_player => false
      )
    ]
  end

  it "should render list of players" do
    render "/players/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "value for position", 2)
    response.should have_tag("tr>td", "value for about", 2)
    response.should have_tag("tr>td", false, 2)
  end
end

