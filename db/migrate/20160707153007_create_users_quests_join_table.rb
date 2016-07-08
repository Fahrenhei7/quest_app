class CreateUsersQuestsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users_quests do |t|
      t.integer :user_id
      t.integer :quest_id
    end
  end
end
