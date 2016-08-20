class CreateSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :suggestions do |t|
      t.text :text
      t.integer :rating
      t.references :mission
      t.integer :status

      t.timestamps
    end
  end
end
