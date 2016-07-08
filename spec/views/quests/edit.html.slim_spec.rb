require 'rails_helper'

RSpec.describe "quests/edit", type: :view do
  before(:each) do
    @quest = assign(:quest, Quest.create!(
      :name => "MyString",
      :description => "MyText",
      :user => nil
    ))
  end

  it "renders the edit quest form" do
    render

    assert_select "form[action=?][method=?]", quest_path(@quest), "post" do

      assert_select "input#quest_name[name=?]", "quest[name]"

      assert_select "textarea#quest_description[name=?]", "quest[description]"

      assert_select "input#quest_user_id[name=?]", "quest[user_id]"
    end
  end
end
