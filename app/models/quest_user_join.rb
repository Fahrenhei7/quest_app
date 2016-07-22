# == Schema Information
#
# Table name: quest_user_joins
#
#  id         :integer          not null, primary key
#  quest_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class QuestUserJoin < ApplicationRecord

  belongs_to :quest
  belongs_to :user

  validates :user_id, uniqueness: { scope: :quest_id }
  validate :user_not_creator

  private

  def user_not_creator
    errors.add(:user, 'can\'t sign to own quest.') if quest.creator_id == user_id
  end

end
