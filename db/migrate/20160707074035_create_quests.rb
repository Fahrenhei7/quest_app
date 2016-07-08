class CreateQuests < ActiveRecord::Migration[5.0]
  def change
    create_table :quests do |t|
      t.string :name
      t.text :description
      t.belongs_to :creator

      t.timestamps
    end
  end
end
