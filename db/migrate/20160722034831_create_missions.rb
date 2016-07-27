class CreateMissions < ActiveRecord::Migration[5.0]
  def change
    create_table :missions do |t|
      t.text :task
      t.string :key
      t.references :quest
      t.integer :difficulty

      t.timestamps
    end
  end
end
