class QuestPolicy < ApplicationPolicy


  attr_reader :user, :quest

  def initialize(user, quest)
    @user = user
    @quest = quest
  end

  def edit?
    user == quest.creator
  end

  def update?
    user == quest.creator
  end

  def destroy?
    user == quest.creator
  end

end


