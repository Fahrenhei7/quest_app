module MissionsHelper
  def owner_of_mission(user, mission)
    mission.quest.creator == user
  end
end
