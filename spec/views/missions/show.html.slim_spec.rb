require 'rails_helper'

RSpec.describe "missions/show", type: :view do
  before(:each) do
    @mission = assign(:mission, Mission.create!(
      :task => "MyText",
      :key => "Key",
      :quest => "",
      :difficulty => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Key/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
