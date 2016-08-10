class CheckKey
  attr_reader :user, :mission, :key_params

  def initialize(user, mission, params)
    @user = user
    @mission = mission
    @key_params = params[:key].strip
  end

  def call
    if mission.keys.include? key_params
      add_points = AddPoints.new(user, mission.cost)
      if add_points.call
        mission.users << user
      end
      true
    else
      false
    end
  end
end
