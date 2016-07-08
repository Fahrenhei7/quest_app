require 'rails_helper'

RSpec.describe "quests/new", type: :view do
  before(:each) do
    assign(:quest, Quest.new(
      :name => "MyString",
      :description => "MyText",
      :user => nil
    ))
  end

  it "renders new quest form" do
    render

    assert_select "form[action=?][method=?]", quests_path, "post" do

      assert_select "input#quest_name[name=?]", "quest[name]"

      assert_select "textarea#quest_description[name=?]", "quest[description]"

      assert_select "input#quest_user_id[name=?]", "quest[user_id]"
    end
  end
end
