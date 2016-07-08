class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :owned_quests, class_name: 'Quest', foreign_key: :creator_id
  #has_and_belongs_to_many :signed_quests, class_name: 'Quest'
  has_and_belongs_to_many :quests, join_table: 'users_quests'
end
