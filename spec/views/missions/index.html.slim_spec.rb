require 'rails_helper'

RSpec.describe "missions/index", type: :view do
  before(:each) do
    assign(:missions, [
      Mission.create!(
        :task => "MyText",
        :key => "Key",
        :quest => "",
        :difficulty => 2
      ),
      Mission.create!(
        :task => "MyText",
        :key => "Key",
        :quest => "",
        :difficulty => 2
      )
    ])
  end

  it "renders a list of missions" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
