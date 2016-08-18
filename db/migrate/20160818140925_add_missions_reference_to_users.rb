class AddMissionsReferenceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :users, :solved_missions
  end
end
