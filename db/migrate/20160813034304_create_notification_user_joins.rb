class CreateNotificationUserJoins < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_user_joins do |t|
      t.belongs_to :notification, index: true
      t.belongs_to :user, index: true
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
