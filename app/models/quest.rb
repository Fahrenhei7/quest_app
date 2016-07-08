class Quest < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  #has_and_belongs_to_many :signed_users, class_name: 'User'
  has_and_belongs_to_many :users, join_table: 'users_quests'
end
