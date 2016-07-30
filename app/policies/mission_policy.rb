class MissionPolicy < ApplicationPolicy

  attr_reader :user, :quest, :mission

  def initialize(user, mission)
    @user = user
    @mission = mission
    @quest = mission.quest
  end

  def new?
    user == quest.creator
  end

  def create?
    user == quest.creator
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

  def check_key?
    user != quest.creator && !mission.users.include?(user)
  end

  #whats wrong?

end


