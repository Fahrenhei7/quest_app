class Quest < ApplicationRecord

  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  has_many :quest_user_joins #join table assosiate
  has_many :signed_users, through: :quest_user_joins, source: :user

end
