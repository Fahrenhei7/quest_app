class CreateMissions < ActiveRecord::Migration[5.0]
  def change
    create_table :missions do |t|
      t.text :task
      t.text :parting
      t.string :keys, array: true, default: []
      t.references :quest
      t.references :solved_by_user
      t.integer :difficulty

      t.timestamps
    end
  end
end
