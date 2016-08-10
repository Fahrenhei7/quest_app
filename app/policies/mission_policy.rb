class MissionPolicy < ApplicationPolicy
  attr_reader :user, :quest, :mission

  def initialize(user, mission)
    @user = user
    @mission = mission
    @quest = mission.quest
  end

  %w(new? create? edit? update? destroy?).each do |m|
    define_method(m) do
      user == quest.creator
    end
  end

  def check_key?
    user && user != quest.creator && !mission.users.include?(user)
  end

  #def see_task?
    #quest.signed_users.include?(user) || user == quest.creator
  #end
end
