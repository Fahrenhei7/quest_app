require 'rails_helper'

RSpec.describe "quests/show", type: :view do
  before(:each) do
    @quest = assign(:quest, Quest.create!(
      :name => "Name",
      :description => "MyText",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
