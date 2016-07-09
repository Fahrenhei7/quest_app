class CreateQuestUserJoins < ActiveRecord::Migration[5.0]
  def change
    create_table :quest_user_joins do |t|
      t.belongs_to :quest, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
