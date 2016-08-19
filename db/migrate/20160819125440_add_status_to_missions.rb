class AddStatusToMissions < ActiveRecord::Migration[5.0]
  def change
    add_column :missions, :status, :integer
  end
end
