require 'rails_helper'

RSpec.describe "missions/edit", type: :view do
  before(:each) do
    @mission = assign(:mission, Mission.create!(
      :task => "MyText",
      :key => "MyString",
      :quest => "",
      :difficulty => 1
    ))
  end

  it "renders the edit mission form" do
    render

    assert_select "form[action=?][method=?]", mission_path(@mission), "post" do

      assert_select "textarea#mission_task[name=?]", "mission[task]"

      assert_select "input#mission_key[name=?]", "mission[key]"

      assert_select "input#mission_quest[name=?]", "mission[quest]"

      assert_select "input#mission_difficulty[name=?]", "mission[difficulty]"
    end
  end
end
