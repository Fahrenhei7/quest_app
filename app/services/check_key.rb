class CheckKey
  attr_reader :user, :mission, :key_params

  def initialize(user, mission, params)
    @user = user
    @mission = mission
    @key_params = params[:key].strip.downcase
  end

  def call
    if mission.keys.include? key_params
      mission.solved_by = user
      add_points = AddPoints.new(user, mission.cost)
      new_notification = CreateNotification.new(user, 'solved_mission',
                                                "You successfully done mission!",
                                                {pts: mission.cost,
                                                 quest: mission.quest.name})
      if mission.save
        add_points.call
        new_notification.call
        true
      end
    else
      false
    end
  end
end
