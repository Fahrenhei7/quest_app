class MissionPolicy < ApplicationPolicy

  attr_reader :user, :quest, :mission

  def initialize(user, mission)
    @user = user
    @mission = mission
    @quest = mission.quest
  end

  %w(new? create? edit? update? destroy?).each do |m|
    define_method("#{m}") do
      user == quest.creator
    end
  end

  def check_key?
    user != quest.creator && !mission.users.include?(user) && quest.signed_users.include?(user)
  end

end


