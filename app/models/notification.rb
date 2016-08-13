# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  body       :string
#  info       :json
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord

 self.inheritance_column = :foo

  enum type: [:solved_mission, :new_mission]
  has_many :users, through: :notification_user_joins
  has_many :notification_user_joins
end
