require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/players/show.html.erb" do
  include PlayersHelper
  
  before(:each) do
    assigns[:player] = @player = stub_model(Player,
      :name => "value for name",
      :height => "1",
      :position => "value for position",
      :about => "value for about",
      :active_player => false
    )
  end

  it "should render attributes in <p>" do
    render "/players/show.html.erb"
    response.should have_text(/value\ for\ name/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ position/)
    response.should have_text(/value\ for\ about/)
    response.should have_text(/als/)
  end
end

