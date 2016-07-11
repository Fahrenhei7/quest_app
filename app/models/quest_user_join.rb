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
