# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  created_quests_id      :integer
#  points                 :integer          default(0)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :created_quests, class_name: 'Quest', foreign_key: :creator_id

  has_many :quest_user_joins #join table associate
  has_many :signed_quests, through: :quest_user_joins, source: :quest
  has_many :notification_user_joins
  has_many :notifications, through: :notification_user_joins

  has_many :solved_missions, class_name: 'Mission', foreign_key: :solved_missions_id

  validates :name, presence: true, length: { minimum: 2, maximum: 25 }


#remember user by default
  def remember_me
    true
  end

end
