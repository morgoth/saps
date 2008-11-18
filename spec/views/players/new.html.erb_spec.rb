require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/players/new.html.erb" do
  include PlayersHelper
  
  before(:each) do
    assigns[:player] = stub_model(Player,
      :new_record? => true,
      :name => "value for name",
      :height => "1",
      :position => "value for position",
      :about => "value for about",
      :active_player => false
    )
  end

  it "should render new form" do
    render "/players/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", players_path) do
      with_tag("input#player_name[name=?]", "player[name]")
      with_tag("input#player_height[name=?]", "player[height]")
      with_tag("input#player_position[name=?]", "player[position]")
      with_tag("textarea#player_about[name=?]", "player[about]")
      with_tag("input#player_active_player[name=?]", "player[active_player]")
    end
  end
end


