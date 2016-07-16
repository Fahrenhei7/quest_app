class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true

  has_many :created_quests, class_name: 'Quest', foreign_key: :creator_id

  has_many :quest_user_joins #join table assosiate
  has_many :signed_quests, through: :quest_user_joins, source: :quest

end
