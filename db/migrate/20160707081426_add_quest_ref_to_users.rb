class AddQuestRefToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :created_quests
  end
end
