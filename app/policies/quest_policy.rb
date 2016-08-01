class QuestPolicy < ApplicationPolicy


  attr_reader :user, :quest

  def initialize(user, quest)
    @user = user
    @quest = quest
  end

  %w(edit? update? destroy?).each do |m|
    define_method("#{m}") do
      user == quest.creator
    end
  end

  def sign?
    quest.signed_users.exclude?(user) && quest.creator != user
  end

  def unsign?
    quest.signed_users.include?(user) && quest.creator != user
  end

end


