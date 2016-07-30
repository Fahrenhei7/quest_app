module MissionsHelper

 def owner_of_mission(mission, user)
    mission.quest.creator == user
 end
 
end
