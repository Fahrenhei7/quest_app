class CreateMissionsUsersJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :missions, :users do |t|
      t.index :mission_id
      t.index :user_id
    end
  end
end
