# == Schema Information
#
# Table name: notification_user_joins
#
#  id              :integer          not null, primary key
#  notification_id :integer
#  user_id         :integer
#  checked         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class NotificationUserJoin < ApplicationRecord
  belongs_to :notification
  belongs_to :user

end
