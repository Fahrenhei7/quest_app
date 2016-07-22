# == Schema Information
#
# Table name: quests
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  creator_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Quest < ApplicationRecord

  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  has_many :quest_user_joins #join table assosiate
  has_many :signed_users, through: :quest_user_joins, source: :user

  validates :name, presence: true, length: { minimum: 4, maximum: 45 }
  validates :description, presence: true, length: { minimum: 15, maximum: 600 }


end
