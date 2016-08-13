class CheckKey
  attr_reader :user, :mission, :key_params

  def initialize(user, mission, params)
    @user = user
    @mission = mission
    @key_params = params[:key].strip.downcase
  end

  def call
    if mission.keys.include? key_params
      mission.users << user
      add_points = AddPoints.new(user, mission.cost)
      add_points.call
      new_notification = CreateNotification.new(user, 0,
                                               "You successfully done mission!",
                                               {pts: mission.cost,
                                                quest: mission.quest.name})
      new_notification.call
      true
    else
      false
    end
  end
end
